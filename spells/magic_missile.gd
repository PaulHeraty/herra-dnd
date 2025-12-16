class_name MagicMissile extends Spell

func _init() -> void:
	name = "Magic Missile"
	spell_type = SPELLTYPE.OFFENSIVE
	level = 1
	spell_sound = preload("res://audio/spells/magic-missiles-wizard-spell-missiles-magic-spookymodem.mp3")
	spell_range = 120
	duration = 0
	bonus_action = false
	components = "V,S"
	desc = """
	You create three glowing darts of magical force. Each dart hits a creature of your choice
	within range that you can see. A dart deals 1d4 + 1 force damage to its target. The darts
	all strike simultaneously, and you can direct them to hit one creature or several.\\n
	  [b]At Higher Levels.[/b] When you case this spell using a spell slot of 2nd level or
	higher, the spell creates one more dart for each slot level above 1st.
	"""
	pass
	
func cast(_caster: CombatEntity, target: CombatEntity):
	GameLog.add_entry("Casting magic missile on " + target.entity_name + "\n")
	var d = Dice.new()
	var amount: int = 1
	for i in 3:
		amount += d.d4()
	target.take_damage(DamageComponent.DAMAGE_TYPE.FORCE, amount)
	pass
