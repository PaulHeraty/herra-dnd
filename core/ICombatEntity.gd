class_name ICombatEntity extends Node

enum ENTITY_TYPE {PLAYER, ENEMY}

var entity_name: String
var initiative: int = 0
var entity_type: ENTITY_TYPE = ENTITY_TYPE.PLAYER

var attack_hit_audio: AudioStream
var attack_miss_audio: AudioStream
var damage_audio: AudioStream
var death_audio: AudioStream

func roll_initiative() -> void:
	# Should be overridden
	initiative = 0
	pass

func take_damage(_dmg_type: DamageComponent.DAMAGE_TYPE, _dmg_amount: int) -> void:
	# Should be overridden
	pass

func heal(heal_amount: int) -> void:
	# Should be overridden
	pass
	
func attack_hit() -> void:
	# Should be overridden
	pass

func attack_miss() -> void:
	# Should be overridden
	pass
