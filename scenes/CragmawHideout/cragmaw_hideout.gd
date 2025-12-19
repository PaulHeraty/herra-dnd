class_name CragmawHideout extends Node2D

@export var music: AudioStream

@onready var cave_ground_floor_ground: TileMapLayer = %CaveGroundFloorGround
@onready var cave_ground_floor_decor: TileMapLayer = %CaveGroundFloorDecor
@onready var cave_floor_one_ground: TileMapLayer = %CaveFloorOneGround
@onready var cave_floor_one_decor: TileMapLayer = %CaveFloorOneDecor
@onready var outside_ground: LevelTileMapLayer = %OutsideGround
@onready var outside_decor: TileMapLayer = %OutsideDecor

@onready var enter_cave: Area2D = $EnterCave
@onready var exit_cave: Area2D = $ExitCave
@onready var upper_cave: Area2D = $UpperCave
@onready var lower_cave: Area2D = $LowerCave


func _ready() -> void:
	cave_floor_one_ground.enabled = false
	cave_floor_one_decor.enabled = false
	PartyManager.set_map_team_position(%PartySpawn.global_position)
	AudioManager.play_music(music)
	enter_cave.body_entered.connect(_on_enter_cave)
	exit_cave.body_entered.connect(_on_exit_cave)
	upper_cave.body_entered.connect(_on_upper_cave)
	lower_cave.body_entered.connect(_on_lower_cave)

func _on_enter_cave(_body: Node2D) -> void:
	outside_ground.enabled = false
	outside_decor.enabled = false
	cave_ground_floor_ground.enabled = true
	cave_ground_floor_decor.enabled = true
	cave_floor_one_ground.enabled = false
	cave_floor_one_decor.enabled = false
	pass
	
func _on_exit_cave(_body: Node2D) -> void:
	outside_ground.enabled = true
	outside_decor.enabled = true
	cave_ground_floor_ground.enabled = true
	cave_ground_floor_decor.enabled = false
	cave_floor_one_ground.enabled = false
	cave_floor_one_decor.enabled = false
	pass
	
func _on_upper_cave(_body: Node2D) -> void:
	outside_ground.enabled = false
	outside_decor.enabled = false
	cave_ground_floor_ground.enabled = false
	cave_ground_floor_decor.enabled = false
	cave_floor_one_ground.enabled = true
	cave_floor_one_decor.enabled = true
	pass
	
func _on_lower_cave(_body: Node2D) -> void:
	outside_ground.enabled = false
	outside_decor.enabled = false
	cave_ground_floor_ground.enabled = true
	cave_ground_floor_decor.enabled = true
	cave_floor_one_ground.enabled = false
	cave_floor_one_decor.enabled = false
	pass
