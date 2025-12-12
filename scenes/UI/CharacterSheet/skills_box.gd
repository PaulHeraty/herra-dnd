class_name SkillsBox extends VBoxContainer

@onready var acrobatics_value: Label = %AcrobaticsValue
@onready var animal_handling_value: Label = %AnimalHandlingValue
@onready var arcana_value: Label = %ArcanaValue
@onready var athletics_value: Label = %AthleticsValue
@onready var deception_value: Label = %DeceptionValue
@onready var history_value: Label = %HistoryValue
@onready var insight_value: Label = %InsightValue
@onready var intimidation_value: Label = %IntimidationValue
@onready var investigation_value: Label = %InvestigationValue
@onready var medicine_value: Label = %MedicineValue
@onready var nature_value: Label = %NatureValue
@onready var perception_value: Label = %PerceptionValue
@onready var performance_value: Label = %PerformanceValue
@onready var persuasion_value: Label = %PersuasionValue
@onready var religion_value: Label = %ReligionValue
@onready var sleight_of_hand_value: Label = %SleightOfHandValue
@onready var stealth_value: Label = %StealthValue
@onready var survival_value: Label = %SurvivalValue


func update_skills(player_char: PlayerCharacter) -> void:
	acrobatics_value.text = get_skill_string(player_char.skills.acrobatics)
	animal_handling_value.text = get_skill_string(player_char.skills.animal_handling)
	arcana_value.text = get_skill_string(player_char.skills.arcana)
	athletics_value.text = get_skill_string(player_char.skills.athletics)
	deception_value.text = get_skill_string(player_char.skills.deception)
	history_value.text = get_skill_string(player_char.skills.history)
	insight_value.text = get_skill_string(player_char.skills.insight)
	intimidation_value.text = get_skill_string(player_char.skills.intimidation)
	investigation_value.text = get_skill_string(player_char.skills.investigation)
	medicine_value.text = get_skill_string(player_char.skills.medicine)
	nature_value.text = get_skill_string(player_char.skills.nature)
	perception_value.text = get_skill_string(player_char.skills.perception)
	performance_value.text = get_skill_string(player_char.skills.performance)
	persuasion_value.text = get_skill_string(player_char.skills.persuasion)
	religion_value.text = get_skill_string(player_char.skills.religion)
	sleight_of_hand_value.text = get_skill_string(player_char.skills.sleight_of_hand)
	stealth_value.text = get_skill_string(player_char.skills.stealth)
	survival_value.text = get_skill_string(player_char.skills.survival)
	pass

func get_skill_string(value: int) -> String:
	if value >= 0:
		return "+" + str(value)
	else:
		return str(value)
