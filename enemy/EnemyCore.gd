class_name EnemyCore extends Resource

@export var name: String = ""
@export var portrait_path: String = ""
@export var attack_hit_sound: String = ""
@export var attack_miss_sound: String = ""
@export var damage_sound: String = ""
@export var death_sound: String = ""
@export var ac: int = 0
@export var hit_dice: HitDice
@export var speed: int = 30
@export var xp: int = 0

@export var alignment: Alignment.AlignmentType = Alignment.AlignmentType.TRUE_NEUTRAL

@export_category("Stats")
@export var stats: Stats

@export var damage_vulnerabilities: Array[String]
@export var damage_immunities: Array[String]
@export var condition_vulnerabilities: Array[String]
@export var senses: Array[String]
@export var languages: Array[String]

@export var equipped_weapons: Array[Weapon]
@export var equipped_armor: Array[Armor]

var saving_throws: SavingThrows = SavingThrows.new()
var skills: Skills = Skills.new()
var proficiency_bonus: int = 2
