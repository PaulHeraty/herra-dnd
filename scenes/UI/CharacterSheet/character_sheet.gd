class_name CharacterSheet extends Control

@onready var char_name: Label = %CharName
@onready var char_class: Label = %CharClass
@onready var char_level: Label = %CharLevel
@onready var background: Label = %Background
@onready var race: Label = %Race
@onready var alignment: Label = %Alignment
@onready var xp: Label = %XP
@onready var ac: Label = %AC
@onready var initiative: Label = %Initiative
@onready var speed: Label = %Speed
@onready var hp: Label = %HP
@onready var saving_throws: VBoxContainer = %SavingThrows
@onready var skills_box: SkillsBox = %SkillsBox
@onready var strength: VBoxContainer = %Strength
@onready var dexterity: VBoxContainer = %Dexterity
@onready var constitution: VBoxContainer = %Constitution
@onready var intelligence: VBoxContainer = %Intelligence
@onready var wisdom: VBoxContainer = %Wisdom
@onready var charisma: VBoxContainer = %Charisma
@onready var portrait: TextureRect = %Portrait


var player_char: PlayerCharacter

func _ready() -> void:
	PartySheet.shown.connect(update_stats)
	pass

func set_character(pc: PlayerCharacter) -> void:
	player_char = pc
	update_stats()
	
func update_stats() -> void:
	char_name.text = player_char.name
	set_portrait()
	char_class.text = get_class_string(player_char.core_data.class_type)
	char_level.text = str(player_char.core_data.level)
	background.text = get_background_string(player_char.core_data.background)
	race.text = get_race_string(player_char.core_data.race) 
	alignment.text = get_alignment_string(player_char.core_data.alignment)
	xp.text = str(player_char.core_data.xp) + "/" + "TBD"
	ac.text = str(player_char.core_data.ac)
	initiative.text = get_initiative_string(player_char)
	speed.text = str(player_char.core_data.speed) + " feet"
	hp.text = str(player_char.core_data.current_hp) + "/" + str(player_char.core_data.max_hp)
	saving_throws.update_STs(player_char)
	skills_box.update_skills(player_char)
	var sts = player_char.core_data.stats
	strength.update("Strength", sts.strength_mod, sts.strength)
	dexterity.update("Dexterity", sts.dexterity_mod, sts.dexterity)
	constitution.update("Constitution", sts.constitution_mod, sts.constitution)
	intelligence.update("Intelligence", sts.intelligence_mod, sts.intelligence)
	wisdom.update("Wisdom", sts.wisdom_mod, sts.wisdom)
	charisma.update("Charisma", sts.charisma_mod, sts.charisma)
	pass

func set_portrait() -> void:
	if player_char.core_data and player_char.core_data.portrait_path != "":
		portrait.texture = load(player_char.core_data.portrait_path)
		portrait.custom_minimum_size = Vector2(256, 256)
		portrait.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		portrait.expand = true
	pass

func get_initiative_string(c: PlayerCharacter) -> String:
	if c.core_data.saving_throws.dexterity >= 0:
		return "+" + str(c.core_data.saving_throws.dexterity)
	else:
		return str(c.core_data.saving_throws.dexterity)
	
func get_class_string(c: Class.ClassType) -> String:
	match c:
		Class.ClassType.FIGHTER:
			return "Fighter"
		Class.ClassType.ROGUE:
			return "Rogue"
		Class.ClassType.WIZARD:
			return "Wizard"
		Class.ClassType.CLERIC:
			return "Cleric"
		_:
			return ""

func get_background_string(b: Background.BackgroundType) -> String:
	match b:
		Background.BackgroundType.CRIMINAL:
			return "Criminal"
		Background.BackgroundType.NOBLE:
			return "Noble"
		Background.BackgroundType.SOLDIER:
			return "Soldier"
		Background.BackgroundType.ACOLYTE:
			return "Acolyte"
		Background.BackgroundType.FOLKHERO:
			return "Folk Hero"
		_:
			return ""
			
func get_race_string(r: Race.RaceType) -> String:
	match r:
		Race.RaceType.HUMAN:
			return "Human"
		Race.RaceType.HALFLING:
			return "Lightfoot Halfling"
		Race.RaceType.ELF:
			return "High Elf"
		Race.RaceType.DWARF:
			return "Hill Dwarf"
		_:
			return ""

func get_alignment_string(a: Alignment.AlignmentType) -> String:
	match a:
		Alignment.AlignmentType.LAWFUL_GOOD:
			return "Lawful Good"
		Alignment.AlignmentType.NEUTRAL_GOOD:
			return "Neutral Good"
		Alignment.AlignmentType.CHAOTIC_GOOD:
			return "Chaotic Good"
		Alignment.AlignmentType.LAWFUL_NEUTRAL:
			return "Lawful Neutral"
		Alignment.AlignmentType.TRUE_NEUTRAL:
			return "True Neutral"
		Alignment.AlignmentType.CHAOTIC_NEUTRAL:
			return "Chaotic Neutral"
		Alignment.AlignmentType.LAWFUL_EVIL:
			return "Lawful Evil"
		Alignment.AlignmentType.NEUTRAL_EVIL:
			return "Neutral Evil"
		Alignment.AlignmentType.CHAOTIC_EVIL:
			return "Chaotic Evil"
		_:
			return ""
