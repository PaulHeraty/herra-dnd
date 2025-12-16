class_name CharacterData extends Resource

@export var name: String = ""
@export var portrait_path: String = ""

@export var class_type: Class.ClassType = Class.ClassType.FIGHTER
@export var race: Race.RaceType = Race.RaceType.HUMAN
@export var background: Background.BackgroundType = Background.BackgroundType.CRIMINAL

@export var max_hp: int = 0
@export var stats: Stats

@export_category("Skills")
@export var proficiency_bonus: int = 2
@export var proficiencies: Array[Skills.SKILLTYPE]
@export var expertise: Array[Skills.SKILLTYPE]

@export_category("Inventory")
@export var equipped_weapons: Array[Weapon]
@export var equipped_armor: Array[Armor]

@export_category("Spells")
@export var known_spells: Array[Spell]

@export_category("Audio")
@export var damaged_sound_path: String = ""
@export var death_sound_path: String = ""

var level: int = 1
var xp: int = 0
