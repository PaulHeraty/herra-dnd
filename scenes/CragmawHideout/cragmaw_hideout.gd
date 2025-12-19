class_name CragmawHideout extends Node2D

@export var music: AudioStream

@onready var tile_map_layer_ground: TileMapLayer = %TileMapLayerGround
@onready var tile_map_layer_ground_2: TileMapLayer = %TileMapLayerGround2
@onready var tile_map_layer_walls: TileMapLayer = %TileMapLayerWalls
@onready var tile_map_layer_outside_ground: LevelTileMapLayer = %TileMapLayerOutsideGround
@onready var tile_map_layer_outside_upper: TileMapLayer = %TileMapLayerOutsideUpper

func _ready() -> void:
	tile_map_layer_ground_2.visible = false
	PartyManager.set_map_team_position(%PartySpawn.global_position)
	AudioManager.play_music(music)
