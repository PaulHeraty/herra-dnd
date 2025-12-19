class_name CragmawHideout extends Node2D

@export var music: AudioStream

@onready var tile_map_layer_ground: TileMapLayer = %TileMapLayerGround
@onready var tile_map_layer_ground_2: TileMapLayer = %TileMapLayerGround2
@onready var tile_map_layer_walls: TileMapLayer = %TileMapLayerWalls
@onready var tile_map_layer_outside_ground: LevelTileMapLayer = %TileMapLayerOutsideGround
@onready var tile_map_layer_outside_upper: TileMapLayer = %TileMapLayerOutsideUpper
#@onready var subviewport_container = $SubViewportContainer

#var map_team: Party
#var high_res_sprite: PartyHiRes

func _ready() -> void:
	tile_map_layer_ground_2.visible = false
	#self.y_sort_enabled = true
	#map_team = PartyManager.spawn_player(%SubViewport)
	PartyManager.set_map_team_position(%PartySpawn.global_position)
	#high_res_sprite = PartyManager.map_team_hires
	#PartyManager.set_as_parent(self)
	#LevelManager.level_load_started.connect(_free_level)
	AudioManager.play_music(music)

#func _process(_delta):
	#var canvas_transform = $SubViewportContainer/SubViewport.get_canvas_transform()
	#var ghost_screen_pos = canvas_transform * map_team.global_position
	#var screen_scale = Vector2(
		#get_viewport().size.x / float($SubViewportContainer/SubViewport.size.x),
		#get_viewport().size.y / float($SubViewportContainer/SubViewport.size.y)
		#)
	#high_res_sprite.position = ghost_screen_pos * screen_scale
	#pass	
	
#func _free_level() -> void:
	#PartyManager.unparent_player(%SubViewport)
	#queue_free()
