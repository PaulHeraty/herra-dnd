extends Node2D

func _ready() -> void:
	visible = false
	#if PartyManager.map_team_spawned == false:
		#PartyManager.set_map_team_position(global_position)
		#PartyManager.map_team_spawned = true
	pass 
