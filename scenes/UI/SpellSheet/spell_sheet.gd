class_name SpellSheet extends Control

signal spell_highlighted(spell: Spell)

@onready var spell_list: VBoxContainer = $Panel/HBoxContainer/ScrollContainer/VBoxContainer
@onready var description: RichTextLabel = $Panel/HBoxContainer/Panel/ScrollContainer/RichTextLabel

var spell_menu_is_shown: bool = false
var _current_spell: Spell = null
	
func set_spells(spells: Array[Spell]):
	visible = true
	clear_spells()

	for spell in spells:
		var btn = Button.new()
		btn.text = spell.name
		btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		btn.pressed.connect(_on_spell_pressed.bind(spell, btn))
		spell_list.add_child(btn)

func _on_spell_pressed(spell: Spell, button: Button):
	_deselect_all_except(button)
	_current_spell = spell
	description.text = spell_description(spell)
	emit_signal("spell_highlighted", spell)

func format_spell_text(raw: String) -> String:
	var text := raw.strip_edges()
	text = text.replace("\\n", "[NEWLINE]")
	text = text.replace("\n", "")
	text = text.replace("[NEWLINE]", "\n")
	return text
	
func spell_description(spell: Spell) -> String:
	var txt: String = "[b]Casting Time: [/b]"
	if spell.bonus_action:
		txt += "1 bonus action\n"
	else:
		txt += "1 action\n"
		
	txt += "[b]Range: [/b]"
	if spell.spell_range > 0:
		txt += str(spell.spell_range) + " feet\n"
	else:
		txt += "Touch\n"
		
	txt += "[b]Components: [/b]" + spell.components + "\n"
	txt += "[b]Duration: [/b]: "
	if spell.duration > 0:
		txt += str(spell.duration)
	else:
		txt += "Instantneous"
	txt += "\n\n"
	
	txt += format_spell_text(spell.desc)
	return txt

func _deselect_all_except(active: Button):
	for child in spell_list.get_children():
		if child is Button and child != active:
			child.button_pressed = false

func clear_spells():
	for child in spell_list.get_children():
		child.queue_free()
	description.text = ""
	_current_spell = null
