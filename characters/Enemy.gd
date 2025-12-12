class_name Enemy extends CombatEntity

signal selected(enemy)

@onready var portrait: TextureRect = %Portrait
@onready var health_bar: ProgressBar = $HealthBar
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var button: Button = $Portrait/Button

var is_alive: bool = true

var core_data: EnemyData

var fail_audio: AudioStream = load("res://audio/combat/meta-failure.mp3")
	
func _ready() -> void:
	copy_core_stats()
	button.pressed.connect(_on_button_pressed)
	set_hp()
	entity_name = core_data.name
	entity_type = ENTITY_TYPE.ENEMY
	health_bar.max_value = max_hp
	health_bar.value = current_hp
	if core_data and core_data.portrait_path != "":
		portrait.texture = load(core_data.portrait_path)
		portrait.custom_minimum_size = Vector2(128, 128)
		portrait.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		portrait.expand = true
	attack_hit_audio = load(core_data.attack_hit_sound_path)
	attack_miss_audio = load(core_data.attack_miss_sound_path)
	damage_audio = load(core_data.damage_sound_path)
	death_audio = load(core_data.death_sound_path)
	pass

func _process(_delta: float) -> void:
	health_bar.value = current_hp
	pass

func copy_core_stats() -> void:
	stats = core_data.stats
	proficiency_bonus = core_data.proficiency_bonus
	proficiencies = core_data.proficiencies
	known_spells = core_data.known_spells
	equipped_weapons = core_data.equipped_weapons
	equipped_armor = core_data.equipped_armor

func _on_button_pressed() -> void:
	if is_alive:
		selected.emit(self)
	else:
		audio_stream_player.stream = fail_audio
		audio_stream_player.play()

func roll_initiative() -> void:
	var d: Dice = Dice.new()
	initiative = d.roll(1, 20) + stats.dexterity_mod
	#GameLog.add_entry(core_data.name + " rolls " + str(initiative) + " initiative\n")
	pass
	
func set_hp() -> void:
	current_hp = calculate_hp(core_data.hit_dice)
	max_hp = current_hp 
	pass

func take_damage(dmg_type: DamageComponent.DAMAGE_TYPE, dmg_amount: int) -> void:
	animation_player.play("hit")
	audio_stream_player.pitch_scale = randf_range(0.95, 1.05)
	audio_stream_player.stream = damage_audio
	audio_stream_player.play()
	GameLog.add_entry(entity_name + " taking " + str(dmg_amount) + " damage of type " + str(dmg_type) + "\n")
	current_hp -= dmg_amount
	GameLog.add_entry(entity_name + " has " + str(current_hp) + " hp left\n")
	if current_hp <= 0:
		await enemy_dead()
	pass

func heal(heal_amount: int) -> void:
	GameLog.add_entry(entity_name + " is healed for " + str(heal_amount) + "\n")
	current_hp += heal_amount
	GameLog.add_entry(entity_name + " has " + str(current_hp) + " hp left\n")
	pass
	
func enemy_dead() -> void:
	GameLog.add_entry(entity_name + " is DEAD!!!!\n")
	is_alive = false
	audio_stream_player.stream = death_audio
	audio_stream_player.play()
	await animation_player.animation_finished
	portrait.modulate = Color("ff0000", 0.5)
	var i: int = EnemyManager.enemy_list.find(self)
	EnemyManager.enemy_list.remove_at(i)
	queue_free()
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

func calculate_hp(hit_dice: HitDice) -> int:
	var d: Dice = Dice.new()
	var hps = d.roll(hit_dice.dice_count, hit_dice.dice_sides) + hit_dice.plus_amount
	return hps
