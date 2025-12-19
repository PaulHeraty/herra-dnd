class_name Level extends Node2D

@onready var subviewport_container = $SubViewportContainer

var map_team: Party
var high_res_sprite: PartyHiRes

func _ready() -> void:
	self.y_sort_enabled = true
	map_team = PartyManager.spawn_player(%SubViewport)
	high_res_sprite = PartyManager.map_team_hires
	high_res_sprite.visible = true
	LevelManager.level_load_started.connect(_free_level)

func _process(_delta):
	set_party_hires_position(map_team, high_res_sprite)
	set_hires_sprite_rot()
	set_enemy_hires_positions()
	pass	

func set_party_hires_position(p: Party, hrp: PartyHiRes) -> void:
	var canvas_transform = $SubViewportContainer/SubViewport.get_canvas_transform()
	var ghost_screen_pos = canvas_transform * p.global_position
	var screen_scale = Vector2(
		get_viewport().size.x / float($SubViewportContainer/SubViewport.size.x),
		get_viewport().size.y / float($SubViewportContainer/SubViewport.size.y)
		)
	hrp.position = ghost_screen_pos * screen_scale
	pass

func set_enemy_hires_positions() -> void:
	var enemies_node = $SubViewportContainer/SubViewport/CragmawHideout/Enemies
	var index = 0
	for encounter in enemies_node.get_children():
		set_enemy_hires_position(encounter, index)
		index +=  encounter.enemies.size()
	pass
	
func set_enemy_hires_position(e: Encounter, index: int) -> void:
	var canvas_transform = $SubViewportContainer/SubViewport.get_canvas_transform()
	var ghost_screen_pos = canvas_transform * e.global_position
	var screen_scale = Vector2(
		get_viewport().size.x / float($SubViewportContainer/SubViewport.size.x),
		get_viewport().size.y / float($SubViewportContainer/SubViewport.size.y)
		)
	EnemyManager.enemy_list[index].high_res_sprite.position = ghost_screen_pos * screen_scale
	EnemyManager.enemy_list[index].high_res_sprite.visible = true
	pass

func _free_level() -> void:
	PartyManager.unparent_player(%SubViewport)
	queue_free()
	pass
	
func set_hires_sprite_rot() -> void:
	var team_dir = map_team.cardinal_direction
	match team_dir:
		Vector2.RIGHT:
			high_res_sprite.rotation_degrees = 270.0
		Vector2.DOWN:
			high_res_sprite.rotation_degrees = 0.0
		Vector2.LEFT:
			high_res_sprite.rotation_degrees = 90.0
		Vector2.UP:
			high_res_sprite.rotation_degrees = 180.0
		_:
			high_res_sprite.rotation_degrees = 0.0
	pass
