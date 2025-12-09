class_name Main extends Node

@onready var panel: Panel = $CanvasLayer/Control/Panel
@onready var game_log: RichTextLabel = $CanvasLayer/Control/Panel/ScrollContainer/GameLog


func _init() -> void:
	pass

func _ready() -> void:
	GameLog.register_log_ui(game_log)
	GameLog.add_entry("Game initialized.\n")
	
	PartyManager.setup_party()
	var p = PartyManager.party[2]
	
	GameLog.add_entry("[color=yellow]\nTest Ability Check[/color]\n")
	print(Rules.ability_check(p.core_data.stats.strength_mod, 10))
	
	GameLog.add_entry("[color=yellow]\nTest Skill Check[/color]\n")
	print(Rules.skill_check(p.core_data.skills.stealth, 10))
	
	GameLog.add_entry("[color=yellow]\nTest Saving Throw Check[/color]\n")
	print(Rules.saving_throw_check(p.core_data.saving_throws.constitution, 10))
	
	GameLog.add_entry("[color=yellow]\nTest Attack Roll[/color]\n")
	print(Rules.attack_roll(p, 12))
	
	GameLog.add_entry("[color=yellow]\nTEST ENEMY[/color]\n")
	var skeleton = EnemyManager.enemy_list[0]
	GameLog.add_entry("Name: " + skeleton.core_data.name +"\n")
	GameLog.add_entry("HPs: " + str(skeleton.core_data.current_hp) +"\n")
	GameLog.add_entry("AC: " + str(skeleton.core_data.ac) +"\n")
	GameLog.add_entry("Weapon: " + skeleton.core_data.equipped_weapons[0].name +"\n")
	GameLog.add_entry("XP: " + str(skeleton.core_data.xp) +"\n")
	await GameLog.advance
	
	GameLog.add_entry("[color=yellow]\nTEST COMBAT[/color]\n")
	CombatManager.turn_loop()
	pass
