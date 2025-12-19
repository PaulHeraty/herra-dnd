class_name EnemyData extends Resource

@export var name: String = ""
@export var portrait_path: String = ""
@export var picture_path: String = ""

@export var stats: Stats

@export var hit_dice: HitDice
@export var xp: int = 0
@export var ac: int = 0

@export_category("Skills")
@export var proficiency_bonus: int = 2
@export var proficiencies: Array[Skills.SKILLTYPE]
@export var expertise: Array[Skills.SKILLTYPE]

@export_category("Inventory")
@export var equipped_weapons: Array[Weapon]
@export var equipped_armor: Array[Armor]

@export_category("Spells")
@export var known_spells: Array[Spell]

@export_category("Other")
@export var damage_vulnerabilities: Array[String]
@export var damage_immunities: Array[String]
@export var condition_immunities: Array[String]
@export var senses: Array[String]
@export var languages: Array[String]

@export_category("Audio Paths")
@export var damaged_sound_path: String = ""
@export var death_sound_path: String = ""
