class_name SavingThrows extends Node

var strength: int = 1 
var dexterity: int = 1
var constitution: int = 1
var intelligence: int = 1
var wisdom: int = 1
var charisma: int = 1

func set_saving_throws( cl: Class.ClassType, sts: Stats, pb: int) -> void:
	strength = sts.get_ability_modifier(sts.strength)
	dexterity = sts.get_ability_modifier(sts.dexterity)
	constitution = sts.get_ability_modifier(sts.constitution)
	intelligence = sts.get_ability_modifier(sts.intelligence)
	wisdom = sts.get_ability_modifier(sts.wisdom)
	charisma = sts.get_ability_modifier(sts.charisma)
	
	match cl:
		Class.ClassType.FIGHTER:
			strength += pb
			constitution += pb
			pass
		Class.ClassType.ROGUE:
			dexterity += pb
			intelligence += pb
			pass
		Class.ClassType.WIZARD:
			intelligence += pb
			wisdom += pb
			pass
		Class.ClassType.CLERIC:
			wisdom += pb
			charisma += pb
			pass
	pass
