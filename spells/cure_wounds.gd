class_name CureWounds extends Spell

func _init() -> void:
	name = "Cure Wounds"
	level = 1
	spell_sound = preload("res://audio/spells/heal-char.mp3")
	pass
	
func cast(caster: CombatEntity, target: CombatEntity):
	GameLog.add_entry("Casting cure wounds on " + target.entity_name + "\n")
	var d = Dice.new()
	var cs = caster.core_data.stats
	var amount = d.d8() + cs.get_ability_modifier(cs.wisdom)
	target.heal(amount)
