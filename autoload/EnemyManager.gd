extends Node

const ENEMY = preload("res://enemy/Enemy.tscn")
#const ENEMY = preload("res://core/ICombatEntity.tscn")
const SKELETON_ENEMY: Resource = preload("res://enemy/enemies/Skeleton.tres")

var enemy_list: Array[Enemy] = []

func _ready() -> void:
	add_players()
	
func add_players() -> void:
	enemy_list.clear()
	add_enemy_instance(SKELETON_ENEMY)
	
func add_enemy_instance(enemy_type: Resource) -> void:
	var enemy = ENEMY.instantiate()
	enemy.core_data = enemy_type
	get_tree().get_root().get_node("/root/EnemyManager").add_child(enemy)
	enemy_list.append(enemy)
	pass
