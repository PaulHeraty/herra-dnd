extends Spell

func _init() -> void:
	name = "Cure Wounds"
	level = 1
	pass
	
func cast(caster: ICombatEntity, target: ICombatEntity):
	GameLog.add_entry("Casting cure wounds\n")
	var d = Dice.new()
	var cs = caster.core_data.stats
	var amount = cs.get_ability_modifier(cs.intelligence)
	target.heal(amount)
