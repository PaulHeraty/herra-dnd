class_name Spell extends Resource

var name: String
var level: int
var spell_sound: AudioStream

func cast(_caster: CombatEntity, _target: CombatEntity):
	push_error("Spell missing cast() implementation")
