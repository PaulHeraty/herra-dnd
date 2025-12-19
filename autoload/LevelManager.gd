extends Node

signal level_load_started
signal level_loaded
signal TileMapBoundsChanged(bounds: Array[Vector2])

var current_tilemap_bounds : Array[Vector2]
var target_transition: String
var position_offset: Vector2

func _ready() -> void:
	await get_tree().process_frame
	level_loaded.emit()
	
func ChangeTileMapBounds(bounds: Array[Vector2]) -> void:
	current_tilemap_bounds = bounds
	TileMapBoundsChanged.emit(bounds)
	
func load_new_level(
	level_path: String,
	_target_transition: String,
	_position_offset: Vector2
) -> void:
	
	# Get a handle to the SubViewPort in Level.tscn
	var viewport = get_tree().get_first_node_in_group("level_container")
	
	get_tree().paused = true
	target_transition = _target_transition
	position_offset = _position_offset
	
	if viewport:
		for child in viewport.get_children():
			if not child is Party:
				child.queue_free()
		var level_resource = load(level_path)
		if level_resource:
			var new_level = level_resource.instantiate()
			viewport.add_child(new_level)
	else:
		await SceneTransition.fade_out()
		level_load_started.emit()
		await get_tree().process_frame
		get_tree().change_scene_to_file("res://scenes/Level.tscn")
		await get_tree().process_frame
		load_new_level(level_path, _target_transition, _position_offset)
	
	await SceneTransition.fade_in()
	
	get_tree().paused = false
	
	await get_tree().process_frame
	
	level_loaded.emit()
	pass
