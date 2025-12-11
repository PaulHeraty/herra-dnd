extends CanvasLayer

signal spell_menu_shown
signal spell_menu_hidden

signal spell_selected(spell)
signal spell_menu_closed()

@onready var list_container := $Control/Panel/VBoxContainer

var spell_menu_is_shown: bool = false

func _ready() -> void:
	hide_spell_sheet()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("show_spell_sheet"):
		if spell_menu_is_shown == false:
			show_spell_sheet()
		else:
			hide_spell_sheet()
		get_viewport().set_input_as_handled()

func show_spell_sheet() -> void:
	visible = true
	spell_menu_is_shown = true
	spell_menu_shown.emit()
	#open(PartyManager.party[1].core_data.known_spells)
	pass
	
func hide_spell_sheet() -> void:
	visible = false
	spell_menu_is_shown = false
	spell_menu_hidden.emit()
	pass
	
func open(spells: Array[Spell]):
	visible = true
	queue_free_children()

	for spell in spells:
		var btn = Button.new()
		btn.text = spell.name
		btn.pressed.connect(func(): _on_spell_pressed(spell))
		list_container.add_child(btn)


func _on_spell_pressed(spell):
	visible = false
	emit_signal("spell_selected", spell)


func _on_CloseButton_pressed():
	visible = false
	emit_signal("spell_menu_closed")

func queue_free_children():
	for child in list_container.get_children():
		child.queue_free()
