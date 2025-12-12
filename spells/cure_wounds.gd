class_name CureWounds extends Spell

func _init() -> void:
	name = "Cure Wounds"
	level = 1
	pass
	
func cast(caster: CombatEntity, target: CombatEntity):
	GameLog.add_entry("Casting cure wounds\n")
	var d = Dice.new()
	var cs = caster.core_data.stats
	var amount = d.d8() + cs.get_ability_modifier(cs.wisdom)
	target.heal(amount)
