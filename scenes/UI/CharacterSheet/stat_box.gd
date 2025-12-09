class_name StatBox extends VBoxContainer

@onready var stat_label: Label = $StatLabel
@onready var bonus_label: Label = $BonusLabel
@onready var value_label: Label = $ValueLabel

func update(stat: String, bonus: int, value: int) -> void:
	stat_label.text = stat
	bonus_label.text = get_bonus_string(bonus)
	value_label.text = str(value)

func get_bonus_string(value: int) -> String:
	if value >= 0:
		return "+" + str(value)
	else:
		return str(value)
