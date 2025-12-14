class_name SpellSheet extends Control

signal spell_selected(spell: Spell)

@onready var spell_list := $Panel/VBoxContainer

var spell_menu_is_shown: bool = false

func _ready() -> void:
	#visible = false
	pass
	
func set_spells(spells: Array[Spell]):
	visible = true
	clear_spells()

	for spell in spells:
		var btn = Button.new()
		btn.text = spell.name
		btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		btn.pressed.connect(_on_spell_pressed.bind(spell))
		spell_list.add_child(btn)

func _on_spell_pressed(spell):
	#visible = false
	emit_signal("spell_selected", spell)

func clear_spells():
	for child in spell_list.get_children():
		child.queue_free()
