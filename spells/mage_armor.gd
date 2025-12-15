class_name MageArmor extends Spell

func _init() -> void:
	name = "Mage Armor"
	spell_type = SPELLTYPE.DEFENSIVE
	level = 1
	spell_sound = preload("res://audio/spells/heal-char.mp3")
	spell_range = 120
	duration = 480
	bonus_action = false
	components = "V,S,M"
	desc = """
	You touch a willing creature who isn't wearing armor, and a protective magical
	force surrounds it until the spell ends. The target's base AC becomes 13 + its
	Dexterity modifier. The spell ends early if the target dons armor or if you
	dismiss the spell as an action.
	"""
	pass
	
func cast(_caster: CombatEntity, target: CombatEntity):
	GameLog.add_entry("Casting mage armor on " + target.entity_name + "\n")
	if target.equipped_armor.size() > 0:
		GameLog.add_entry("Target is already wearing armor so spell has no effect!\n")
		return
	var mage_armor := StatModifier.new()
	mage_armor.stat = "ac"
	mage_armor.value = 3
	mage_armor.source = "Mage Armor"
	target.add_modifier(mage_armor)
