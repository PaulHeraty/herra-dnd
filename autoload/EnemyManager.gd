extends Node

signal enemy_selected(enemy)

const ENEMY = preload("res://characters/Enemy.tscn")
#const ENEMY = preload("res://core/ICombatEntity.tscn")
const SKELETON_ENEMY: Resource = preload("res://characters/enemies/Skeleton.tres")
const SKELETON_ENEMY1: Resource = preload("res://characters/enemies/Skeleton.tres")
const SKELETON_ENEMY2: Resource = preload("res://characters/enemies/Skeleton.tres")

var enemy_list: Array[Enemy] = []

func _ready() -> void:
	pass
	
func add_enemies() -> void:
	enemy_list.clear()
	add_enemy_instance(SKELETON_ENEMY)
	add_enemy_instance(SKELETON_ENEMY1)
	add_enemy_instance(SKELETON_ENEMY2)
	
func add_enemy_instance(enemy_type: Resource) -> void:
	var enemy = ENEMY.instantiate()
	enemy.core_data = enemy_type
	get_tree().get_root().get_node("/root/Main/Enemies").add_child(enemy)
	enemy.selected.connect(_on_enemy_selected)
	enemy_list.append(enemy)
	pass

func _on_enemy_selected(enemy:Enemy) -> void:
	enemy_selected.emit(enemy)
	pass
