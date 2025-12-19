class_name Level extends Node2D

@onready var subviewport_container = $SubViewportContainer

var map_team: Party
var high_res_sprite: PartyHiRes

func _ready() -> void:
	self.y_sort_enabled = true
	map_team = PartyManager.spawn_player(%SubViewport)
	high_res_sprite = PartyManager.map_team_hires
	LevelManager.level_load_started.connect(_free_level)

func _process(_delta):
	var canvas_transform = $SubViewportContainer/SubViewport.get_canvas_transform()
	var ghost_screen_pos = canvas_transform * map_team.global_position
	var screen_scale = Vector2(
		get_viewport().size.x / float($SubViewportContainer/SubViewport.size.x),
		get_viewport().size.y / float($SubViewportContainer/SubViewport.size.y)
		)
	high_res_sprite.position = ghost_screen_pos * screen_scale
	set_hires_sprite_rot()
	pass	
	
func _free_level() -> void:
	PartyManager.unparent_player(%SubViewport)
	queue_free()
	
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
