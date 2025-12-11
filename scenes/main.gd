class_name Main extends Node

@onready var panel: Panel = $CanvasLayer/Control/Panel
@onready var game_log: RichTextLabel = $CanvasLayer/Control/Panel/ScrollContainer/GameLog

func _init() -> void:
	pass

func _ready() -> void:
	GameLog.register_log_ui(game_log)
	GameLog.add_entry("Game initialized.\n")
	
	PartyManager.setup_party()
	EnemyManager.add_enemies()
	draw_monsters()
	draw_players()

	GameLog.add_entry("[color=cyan]\nTEST COMBAT[/color]\n")
	CombatManager.enter_combat()
	pass

func _process(_delta: float) -> void:
	draw_monsters()
	draw_players()

func draw_players() -> void:
	for i in PartyManager.party.size():
		PartyManager.party[i].position.y = 250
		PartyManager.party[i].position.x = i*200
	pass
	
func draw_monsters() -> void:
	for i in EnemyManager.enemy_list.size():
		EnemyManager.enemy_list[i].position.y = 10
		EnemyManager.enemy_list[i].position.x = i*200
	pass
