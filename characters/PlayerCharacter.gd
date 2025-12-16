class_name PlayerCharacter extends CombatEntity

signal selected(player)

@onready var portrait: TextureRect = $Portrait
@onready var health_bar: ProgressBar = $HealthBar
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var button: Button = $Portrait/Button

var core_data: CharacterData
var is_alive: bool = true

func _ready() -> void:
	copy_core_stats()
	button.pressed.connect(_on_button_pressed)
	speed = get_race_speed(core_data.race)
	current_hp = max_hp
	health_bar.max_value = max_hp
	health_bar.value = current_hp
	entity_name = core_data.name
	entity_type = ENTITY_TYPE.PLAYER
	saving_throws.set_saving_throws(core_data.class_type, stats, proficiency_bonus)
	skills.set_skills(self)
	if core_data and core_data.portrait_path != "":
		portrait.texture = load(core_data.portrait_path)
		portrait.custom_minimum_size = Vector2(128, 128)
		portrait.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		portrait.expand = true
	ac = get_ac()
	damaged_audio = load(core_data.damaged_sound_path)
	death_audio = load(core_data.death_sound_path)
	for w in equipped_weapons:
		w._init()
	pass
	
func _on_button_pressed() -> void:
	selected.emit(self)
		
func copy_core_stats() -> void:
	entity_name = core_data.name
	stats = core_data.stats
	max_hp = core_data.max_hp
	proficiency_bonus = core_data.proficiency_bonus
	proficiencies = core_data.proficiencies
	known_spells = core_data.known_spells
	equipped_weapons = core_data.equipped_weapons
	equipped_armor = core_data.equipped_armor

func _process(_delta: float) -> void:
	health_bar.value = current_hp
	pass

func play_audio(stream: AudioStream) -> void:
	audio_stream_player.stream = stream
	audio_stream_player.pitch_scale = randf_range(0.95, 1.05)
	audio_stream_player.play()
	pass
	
func roll_initiative() -> void:
	var d: Dice = Dice.new()
	initiative = d.roll(1, 20) + stats.dexterity_mod
	#GameLog.add_entry(core_data.name + " rolls " + str(initiative) + " initiative\n")

func take_damage(dmg_type: DamageComponent.DAMAGE_TYPE, dmg_amount: int) -> void:
	if dmg_amount > 0:
		animation_player.play("hit")
		play_audio(damaged_audio)
		GameLog.add_entry(entity_name + " taking " + str(dmg_amount) + " damage of type " + str(dmg_type) + "\n")
		current_hp -= dmg_amount
		GameLog.add_entry(entity_name + " has " + str(current_hp) + " hps left\n")
	if current_hp <= 0:
		await player_dead()
	CombatManager.current_combat_state = CombatManager.CombatState.TARGET_DAMAGED
	pass

func heal(heal_amount: int) -> void:
	GameLog.add_entry(entity_name + " is healed for " + str(heal_amount) + "\n")
	current_hp += heal_amount
	if current_hp > max_hp:
		current_hp = max_hp
	GameLog.add_entry(entity_name + " has " + str(current_hp) + " hp left\n")
	if current_hp > 0:
		portrait.modulate = Color("ffffff", 1.0)
	pass
	
func player_dead() -> void:
	GameLog.add_entry(entity_name + " is UNCONSCIOUS!!!!\n")
	is_alive = false
	play_audio(death_audio)
	await animation_player.animation_finished
	portrait.modulate = Color("ff0000", 0.5)
	pass
	
func get_ac() -> int:
	var temp_ac = 0
	# First add armor AC and shield
	if equipped_armor.size() > 0:
		for a in equipped_armor:
			temp_ac += a.ac
	else:
		temp_ac = 10
	
	# Now add DEX mod 
	if equipped_armor.size() > 0:
		for a in equipped_armor:
			if a.armor_type == Armor.ARMOR_TYPE.LIGHT:
				temp_ac += stats.dexterity_mod
			elif a.armor_type == Armor.ARMOR_TYPE.MEDIUM:
				temp_ac += min(stats.dexterity_mod, 2)
	else:
		temp_ac += stats.dexterity_mod
	
	# Now add modifiers if any
	for mod in modifiers:
		if mod.stat == "ac":
			temp_ac += mod.value
			
	return temp_ac

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

func learn_spell(spell: Spell) -> void:
	known_spells.append(spell)
	pass
	
func cast_spell(spell: Spell, target: CombatEntity) -> void:
	play_audio(spell.spell_sound)
	await audio_stream_player.finished
	spell.cast(self, target)
	if spell.spell_type == Spell.SPELLTYPE.OFFENSIVE:
		while CombatManager.current_combat_state != CombatManager.CombatState.TARGET_DAMAGED:
			#GameLog.add_entry("WAITING ON ATTACK FINISHED\n")
			await get_tree().create_timer(0.1).timeout
			pass
	CombatManager.current_combat_state = CombatManager.CombatState.SPELL_FINISHED
	pass

func award_xp(xp: int) -> void:
	core_data.xp += xp
