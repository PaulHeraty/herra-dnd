extends CanvasLayer

signal shown
signal hidden
signal spell_selected(spell: Spell)
signal spellbook_cancelled


@onready var tabs: TabContainer = $Control/TabContainer
@onready var select_button: Button = $Control/HBoxContainer/SelectSpell
@onready var close_button: Button = $Control/HBoxContainer/Close

var is_shown: bool = false
var _highlighted_spell: Spell = null

func _ready() -> void:
	hide_spell_book()
	if not select_button.pressed.is_connected(_on_select_spell_pressed):
		select_button.pressed.connect(_on_select_spell_pressed)
	if not close_button.pressed.is_connected(_on_close_pressed):
		close_button.pressed.connect(_on_close_pressed)
	pass

func show_spell_book(actor: CombatEntity) -> void:
	visible = true
	refresh_tabs(actor)
	tabs.current_tab = 0
	tabs.get_tab_bar().grab_focus()
	is_shown = true
	shown.emit()
	pass
	
func hide_spell_book() -> void:
	visible = false
	is_shown = false
	hidden.emit()
	pass
	
func refresh_tabs(actor: CombatEntity) -> void:
	if actor == null:
		return
	var known_spells: Array[Spell] = actor.known_spells
	for i in tabs.get_tab_count():
		var sheet: SpellSheet = tabs.get_child(i)
		var spells_of_this_level: Array[Spell] = get_spells_by_level(known_spells, i)
		sheet.set_spells(spells_of_this_level)
		if not sheet.spell_highlighted.is_connected(_on_spell_highlighted):
			sheet.spell_highlighted.connect(_on_spell_highlighted)
	pass

func get_spells_by_level(known_spells: Array[Spell], level: int) -> Array[Spell]:
	var spells: Array[Spell] = []
	for spell in known_spells:
		if spell.level == level:
			spells.append(spell)
	return spells

func _on_spell_highlighted(spell):
	_highlighted_spell = spell
	select_button.disabled = false
	GameLog.add_entry("Highlighted spell: " + spell.name + "\n")

func _on_select_spell_pressed():
	visible = false
	is_shown = false
	hidden.emit()
	if _highlighted_spell:
		GameLog.add_entry("Selected spell: " + _highlighted_spell.name + "\n")
		emit_signal("spell_selected", _highlighted_spell)

func _on_close_pressed():
	visible = false
	is_shown = false
	hidden.emit()
	GameLog.add_entry("No spell selected.\n")
	emit_signal("spellbook_cancelled")
