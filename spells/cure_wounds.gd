class_name CureWounds extends Spell

func _init() -> void:
	name = "Cure Wounds"
	spell_type = SPELLTYPE.DEFENSIVE
	level = 1
	spell_sound = preload("res://audio/spells/heal-char.mp3")
	spell_range = 0
	duration = 0
	bonus_action = false
	components = "V,S"
	desc = """
	A creature you touch regains a number of hit points equal to 1d8 + your
	spell casting ability modifier. The spell has no effect on undead or 
	constructs.\\n
	  [b]At Higher Levels.[/b] When you cast this spell using a spell slot
	of 2nd or higher level, the healing increases by 1d8 for each slot level 
	above 1st.
	"""
	pass
	
func cast(caster: CombatEntity, target: CombatEntity):
	GameLog.add_entry("Casting cure wounds on " + target.entity_name + "\n")
	var d = Dice.new()
	var cs = caster.core_data.stats
	var amount = d.d8() + cs.get_ability_modifier(cs.wisdom)
	target.heal(amount)
