class_name MagicMissile extends Spell

func _init() -> void:
	name = "Magic Missile"
	level = 1
	spell_sound = preload("res://audio/spells/magic-missiles-wizard-spell-missiles-magic-spookymodem.mp3")
	pass
	
func cast(_caster: CombatEntity, target: CombatEntity):
	GameLog.add_entry("Casting magic missile on " + target.entity_name + "\n")
	var d = Dice.new()
	var amount: int = 1
	for i in 3:
		amount += d.d4()
	target.take_damage(DamageComponent.DAMAGE_TYPE.FORCE, amount)
