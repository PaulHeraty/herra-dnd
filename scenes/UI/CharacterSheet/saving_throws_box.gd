class_name SavingThrowsBox extends VBoxContainer

@onready var strength_value: Label = $Strength/StrengthValue
@onready var dexterity_value: Label = $Dexterity/DexterityValue
@onready var constitution_value: Label = $Constitution/ConstitutionValue
@onready var intelligence_value: Label = $Intelligence/IntelligenceValue
@onready var wisdom_value: Label = $Wisdom/WisdomValue
@onready var charisma_value: Label = $Charisma/CharismaValue

func update_STs(player_char: PlayerCharacter) -> void:
	strength_value.text = get_ST_string(player_char.saving_throws.strength_modifier)
	dexterity_value.text = get_ST_string(player_char.saving_throws.dexterity_modifier)
	constitution_value.text = get_ST_string(player_char.saving_throws.constitution_modifier)
	intelligence_value.text = get_ST_string(player_char.saving_throws.intelligence_modifier)
	wisdom_value.text = get_ST_string(player_char.saving_throws.wisdom_modifier)
	charisma_value.text = get_ST_string(player_char.saving_throws.charisma_modifier)
	pass

func get_ST_string(value: int) -> String:
	if value >= 0:
		return "+" + str(value)
	else:
		return str(value)
