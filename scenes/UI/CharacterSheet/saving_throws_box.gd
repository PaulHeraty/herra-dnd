class_name SavingThrowsBox extends VBoxContainer

@onready var strength_value: Label = $Strength/StrengthValue
@onready var dexterity_value: Label = $Dexterity/DexterityValue
@onready var constitution_value: Label = $Constitution/ConstitutionValue
@onready var intelligence_value: Label = $Intelligence/IntelligenceValue
@onready var wisdom_value: Label = $Wisdom/WisdomValue
@onready var charisma_value: Label = $Charisma/CharismaValue

func update_STs(player_char: PlayerCharacter) -> void:
	strength_value.text = get_ST_string(player_char.core_data.saving_throws.strength)
	dexterity_value.text = get_ST_string(player_char.core_data.saving_throws.dexterity)
	constitution_value.text = get_ST_string(player_char.core_data.saving_throws.constitution)
	intelligence_value.text = get_ST_string(player_char.core_data.saving_throws.intelligence)
	wisdom_value.text = get_ST_string(player_char.core_data.saving_throws.wisdom)
	charisma_value.text = get_ST_string(player_char.core_data.saving_throws.charisma)
	pass

func get_ST_string(value: int) -> String:
	if value >= 0:
		return "+" + str(value)
	else:
		return str(value)
