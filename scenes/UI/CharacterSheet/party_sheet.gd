extends CanvasLayer

signal shown
signal hidden

@onready var tab_container: TabContainer = %TabContainer

var character_sheet_scene = preload("res://scenes/UI/CharacterSheet/CharacterSheet.tscn")

var is_shown: bool = false

func _ready() -> void:
	hide_party_sheet()
	# Set tab names to player character names
	#for i in tab_container.get_tab_count():
		#tab_container.get_child(i).name = PartyManager.party[i].core_data.name
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("show_party_sheet"):
		if is_shown == false:
			show_party_sheet()
		else:
			hide_party_sheet()
		get_viewport().set_input_as_handled()

func show_party_sheet() -> void:
	for i in tab_container.get_tab_count():
		tab_container.get_child(i).name = PartyManager.party[i].core_data.name
	visible = true
	refresh_tabs()
	tab_container.current_tab = 0
	tab_container.get_tab_bar().grab_focus()
	is_shown = true
	shown.emit()
	pass
	
func hide_party_sheet() -> void:
	visible = false
	is_shown = false
	hidden.emit()
	pass

func refresh_tabs() -> void:
	for i in tab_container.get_tab_count():
		var pc = PartyManager.party[i]
		var tab = tab_container.get_child(i)
		tab.set_character(pc)
	pass
