class_name Spell extends Resource

var name: String
var level: int

func cast(caster: ICombatEntity, target: ICombatEntity):
	push_error("Spell missing cast() implementation")
