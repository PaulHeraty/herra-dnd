class_name PlayerCharacter extends ICombatEntity

@onready var portrait: TextureRect = $Portrait
@onready var health_bar: ProgressBar = $HealthBar
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var core_data: Character
var is_alive: bool = true

var attack_hit_audio: AudioStream
var attack_miss_audio: AudioStream
var damage_audio: AudioStream
var death_audio: AudioStream

func _ready() -> void:
	core_data.speed = get_race_speed(core_data.race)
	core_data.current_hp = core_data.max_hp
	health_bar.max_value = core_data.max_hp
	health_bar.value = core_data.current_hp
	entity_name = core_data.name
	entity_type = ENTITY_TYPE.PLAYER
	if core_data and core_data.portrait_path != "":
		portrait.texture = load(core_data.portrait_path)
		portrait.custom_minimum_size = Vector2(128, 128)
		portrait.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		portrait.expand = true
	set_ac()
	if core_data.equipped_weapons[0].weapon_type == Weapon.WEAPON_TYPE.MARTIAL_RANGED:
		attack_hit_audio = load("res://audio/combat/archer-shot.mp3")
	else:
		attack_hit_audio = load("res://audio/combat/sword-on-flesh.mp3")
		attack_miss_audio = load("res://audio/combat/atk-sword-swing.mp3")
	damage_audio = load("res://audio/combat/sword-on-flesh.mp3")
	death_audio = load("res://audio/combat/grunt.mp3")
	pass

func _process(_delta: float) -> void:
	health_bar.value = core_data.current_hp
	pass

func attack_hit() -> void:
	audio_stream_player.stream = attack_hit_audio
	audio_stream_player.pitch_scale = randf_range(0.95, 1.05)
	audio_stream_player.play()
	pass
	
func attack_miss() -> void:
	audio_stream_player.stream = attack_miss_audio
	audio_stream_player.pitch_scale = randf_range(0.95, 1.05)
	audio_stream_player.play()
	pass
	
func roll_initiative() -> void:
	var d: Dice = Dice.new()
	initiative = d.roll(1, 20) + core_data.stats.dexterity_mod
	#GameLog.add_entry(core_data.name + " rolls " + str(initiative) + " initiative\n")

func take_damage(dmg_type: DamageComponent.DAMAGE_TYPE, dmg_amount: int) -> void:
	animation_player.play("hit")
	GameLog.add_entry(entity_name + " taking " + str(dmg_amount) + " damage of type " + str(dmg_type) + "\n")
	core_data.current_hp -= dmg_amount
	GameLog.add_entry(entity_name + " has " + str(core_data.current_hp) + " hps left\n")
	if core_data.current_hp <= 0:
		player_dead()
	pass
	
func player_dead() -> void:
	GameLog.add_entry(entity_name + " is DEAD!!!!\n")
	is_alive = false
	audio_stream_player.stream = death_audio
	audio_stream_player.play()
	await animation_player.animation_finished
	portrait.modulate = Color("ff0000", 0.5)
	pass
	
func set_ac() -> void:
	var ac = 0
	# First add armor AC and shield
	if core_data.equipped_armor.size() > 0:
		for a in core_data.equipped_armor:
			ac += a.ac
	else:
		ac = 10
	
	# Now add DEX mod 
	if core_data.equipped_armor.size() > 0:
		for a in core_data.equipped_armor:
			if a.armor_type == Armor.ARMOR_TYPE.LIGHT:
				ac += core_data.stats.dexterity_mod
			elif a.armor_type == Armor.ARMOR_TYPE.MEDIUM:
				ac += min(core_data.stats.dexterity_mod, 2)
	else:
		ac += core_data.stats.dexterity_mod
	
	core_data.ac = ac

func get_race_speed(race: Race.RaceType) -> int:
	match race:
		Race.RaceType.HUMAN:
			return 30
		Race.RaceType.DWARF:
			return 25
		Race.RaceType.HALFLING:
			return 25
		Race.RaceType.ELF:
			return 30
		_:
			return 0
