class_name Armor extends Resource

enum ARMOR_TYPE {LIGHT, MEDIUM, HEAVY, SHIELD}

@export var name: String = ""
@export var armor_type: ARMOR_TYPE = ARMOR_TYPE.LIGHT
@export var cost: int = 0
@export var ac: int = 0
@export var weight: int = 0
