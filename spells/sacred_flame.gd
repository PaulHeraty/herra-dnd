class_name SacredFlame extends Spell

func _init() -> void:
	name = "Sacred Flame"
	spell_type = SPELLTYPE.OFFENSIVE
	level = 0
	spell_sound = preload("res://audio/spells/flame.mp3")
func cast(caster: CombatEntity, target: CombatEntity):
	GameLog.add_entry("Casting sacred flame on " + target.entity_name + "\n")
	# First target makes a dexterity check
	var dc: int = 8 + caster.stats.wisdom_mod + caster.proficiency_bonus
	var dex_check: bool = Rules.saving_throw_check(target.saving_throws.dexterity_modifier, dc)
	if dex_check:
		GameLog.add_entry(target.entity_name + " passed it's dexterity saving throw and avoids damage\n")
		return
	else:
		GameLog.add_entry(target.entity_name + " failed it's dexterity check\n")
	var d = Dice.new()
	var amount: int = d.d8()
	target.take_damage(DamageComponent.DAMAGE_TYPE.RADIANT, amount)
