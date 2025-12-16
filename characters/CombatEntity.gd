class_name CombatEntity extends Node

enum ENTITY_TYPE {PLAYER, ENEMY}

var entity_name: String
var initiative: int = 0
var entity_type: ENTITY_TYPE = ENTITY_TYPE.PLAYER

var attack_miss_audio: AudioStream
var damaged_audio: AudioStream
var death_audio: AudioStream

var saving_throws: SavingThrows = SavingThrows.new()
var skills: Skills = Skills.new()
var speed: int = 30
var alignment: Alignment.AlignmentType = Alignment.AlignmentType.TRUE_NEUTRAL
var current_hp: int = 0
var ac: int = 0
var modifiers: Array[StatModifier] = []

# Copied stats
var stats: Stats
var max_hp: int
var proficiency_bonus: int
var proficiencies: Array[Skills.SKILLTYPE]
var known_spells: Array[Spell]
var equipped_weapons: Array[Weapon]
var equipped_armor: Array[Armor]

# Interface functions 
func roll_initiative() -> void: pass
func take_damage(_dmg_type: DamageComponent.DAMAGE_TYPE, _dmg_amount: int) -> void: pass
func heal(_heal_amount: int) -> void: pass
func attack_hit() -> void: pass
func attack_miss() -> void: pass
func get_ac() -> int: return 0
func learn_spell(_spell: Spell) -> void: pass
func cast_spell(_spell: Spell, _target: CombatEntity) -> void: pass
func play_audio(_stream: AudioStream) -> void: pass

func add_modifier(mod: StatModifier) -> void:
	modifiers.append(mod)
	
func has_modifier(mod: StatModifier) -> bool:
	for m in modifiers:
		if m.source == mod.source:
			return true
	return false
		 
func remove_modifiers_from_source(source: String) -> void:
	modifiers = modifiers.filter(func(m): return m.source != source)
	pass
	
