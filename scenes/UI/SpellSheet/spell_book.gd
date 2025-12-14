extends CanvasLayer

signal shown
signal hidden
signal spell_selected(spell: Spell)

@onready var tab: TabContainer = $Control/TabContainer

var is_shown: bool = false

func _ready() -> void:
	hide_spell_book()
	pass

func show_spell_book(actor: CombatEntity) -> void:
	visible = true
	refresh_tabs(actor)
	tab.current_tab = 0
	tab.get_tab_bar().grab_focus()
	is_shown = true
	shown.emit()
	pass
	
func hide_spell_book() -> void:
	visible = false
	is_shown = false
	hidden.emit()
	pass
	
func refresh_tabs(actor: CombatEntity) -> void:
	var known_spells: Array[Spell] = actor.known_spells
	for i in tab.get_tab_count():
		var sheet: SpellSheet = tab.get_child(i)
		var spells_of_this_level: Array[Spell] = get_spells_by_level(known_spells, i)
		sheet.set_spells(spells_of_this_level)
		if not sheet.spell_selected.is_connected(_on_spell_selected):
			sheet.spell_selected.connect(_on_spell_selected)
	pass

func get_spells_by_level(known_spells: Array[Spell], level: int) -> Array[Spell]:
	var spells: Array[Spell] = []
	for spell in known_spells:
		if spell.level == level:
			spells.append(spell)
	return spells

func _on_spell_selected(spell):
	visible = false
	GameLog.add_entry("Selected spell: " + spell.name + "\n")
	emit_signal("spell_selected", spell)
