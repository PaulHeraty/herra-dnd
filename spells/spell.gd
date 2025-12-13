class_name Spell extends Resource

enum SPELLTYPE {OFFENSIVE, DEFENSIVE, SUMMON}

var name: String
var spell_type: SPELLTYPE
var level: int
var spell_sound: AudioStream

func cast(_caster: CombatEntity, _target: CombatEntity):
	push_error("Spell missing cast() implementation")
