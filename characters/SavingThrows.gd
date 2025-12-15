class_name SavingThrows extends Node

var strength_modifier: int = 1 
var dexterity_modifier: int = 1
var constitution_modifier: int = 1
var intelligence_modifier: int = 1
var wisdom_modifier: int = 1
var charisma_modifier: int = 1

func set_saving_throws( cl: Class.ClassType, sts: Stats, pb: int) -> void:
	strength_modifier = sts.get_ability_modifier(sts.strength)
	dexterity_modifier = sts.get_ability_modifier(sts.dexterity)
	constitution_modifier = sts.get_ability_modifier(sts.constitution)
	intelligence_modifier = sts.get_ability_modifier(sts.intelligence)
	wisdom_modifier = sts.get_ability_modifier(sts.wisdom)
	charisma_modifier = sts.get_ability_modifier(sts.charisma)
	
	match cl:
		Class.ClassType.FIGHTER:
			strength_modifier += pb
			constitution_modifier += pb
			pass
		Class.ClassType.ROGUE:
			dexterity_modifier += pb
			intelligence_modifier += pb
			pass
		Class.ClassType.WIZARD:
			intelligence_modifier += pb
			wisdom_modifier += pb
			pass
		Class.ClassType.CLERIC:
			wisdom_modifier += pb
			charisma_modifier += pb
			pass
		Class.ClassType.ENEMY:
			pass
	pass
