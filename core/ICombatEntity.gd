class_name ICombatEntity extends Node

enum ENTITY_TYPE {PLAYER, ENEMY}

var entity_name: String
var initiative: int = 0
var entity_type: ENTITY_TYPE = ENTITY_TYPE.PLAYER

func roll_initiative() -> void:
	# Should be overridden
	initiative = 0
	pass

func take_damage(dmg_type: DamageComponent.DAMAGE_TYPE, dmg_amount: int) -> void:
	# Should be overridden
	pass
