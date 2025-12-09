class_name Stats extends Resource

@export var strength: int = 1 : 
	set(v):
		strength = v
		strength_mod = get_ability_modifier(strength)
@export var dexterity: int = 1 :
	set(v):
		dexterity = v
		dexterity_mod = get_ability_modifier(dexterity)
@export var constitution: int = 1 :
	set(v):
		constitution = v
		constitution_mod = get_ability_modifier(constitution)
@export var intelligence: int = 1 :
	set(v):
		intelligence = v
		intelligence_mod = get_ability_modifier(intelligence)
@export var wisdom: int = 1 :
	set(v):
		wisdom = v
		wisdom_mod = get_ability_modifier(wisdom)
@export var charisma: int = 1 :
	set(v):
		charisma = v
		charisma_mod = get_ability_modifier(charisma)

var strength_mod: int = 0
var dexterity_mod: int = 0
var constitution_mod: int = 0
var intelligence_mod: int = 0
var wisdom_mod: int = 0
var charisma_mod: int = 0

func get_ability_modifier(ability_score: int) -> int:
	match ability_score:
		1:
			return -5
		2,3:
			return -4
		4,5:
			return -3
		6,7:
			return -2
		8,9:
			return -1
		10,11:
			return 0
		12,13:
			return 1
		14,15:
			return 2
		16,17:
			return 3
		18,19:
			return 4
		20,21:
			return 5
		22,23:
			return 6
		24,25:
			return 7
		26,27:
			return 8
		28,29:
			return 9
		_:
			return 10
