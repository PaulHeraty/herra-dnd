class_name Encounter extends Node2D

@export var enemies: Array[EnemyData] = []
@export var attack_radius: int = 50

@onready var area_2d: Area2D = $Area2D
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	sprite_2d.texture = load(enemies[0].picture_path)
	var target_size = Vector2(16, 16)
	var tex_size = sprite_2d.texture.get_size()
	sprite_2d.scale = target_size / tex_size
	area_2d.body_entered.connect(_trigger_combat)
	EnemyManager.add_enemies(enemies)
	sprite_2d.visible = false
	pass
	
func _trigger_combat(_body: Node2D) -> void:
	print("TRIGGERING COMBAT!!\n")
	pass
