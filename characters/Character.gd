class_name Character extends Resource

@export var name: String = ""
@export var class_type: Class.ClassType = Class.ClassType.FIGHTER
@export var race: Race.RaceType = Race.RaceType.HUMAN
@export var background: Background.BackgroundType = Background.BackgroundType.CRIMINAL
@export var alignment: Alignment.AlignmentType = Alignment.AlignmentType.TRUE_NEUTRAL
@export var max_hp: int = 0

@export_category("Stats")
@export var stats: Stats 

@export var proficiencies: Array[Skills.SkillType]
@export var expertise: Array[Skills.SkillType]
@export var proficiency_bonus: int = 2

@export var equipped_weapons: Array[Weapon]
@export var equipped_armor: Array[Armor]

var saving_throws: SavingThrows = SavingThrows.new()
var skills: Skills = Skills.new()

var level: int = 1
var ac: int = 0
var speed: int = 0
var current_hp: int = 0
var xp: int = 0
var is_alive: bool = true
