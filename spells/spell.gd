class_name Spell extends Resource

enum SPELLTYPE {OFFENSIVE, DEFENSIVE, SUMMON}

var name: String
var level: int
var spell_type: SPELLTYPE
var desc: String
var spell_range: int
var duration: int
var bonus_action: bool = false
var components: String
var spell_sound: AudioStream

func cast(_caster: CombatEntity, _target: CombatEntity):
	push_error("Spell missing cast() implementation")
