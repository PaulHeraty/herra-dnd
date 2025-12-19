extends Node

signal enemy_selected(enemy)

const ENEMY = preload("res://characters/Enemy.tscn")

var enemy_list: Array[Enemy] = []

func _ready() -> void:
	enemy_list.clear()
	pass
	
func add_enemies(enemies: Array[EnemyData]) -> void:
	for enemy in enemies:
		add_enemy_instance(enemy)
	pass
	
func add_enemy_instance(enemy_type: EnemyData) -> void:
	var enemy = ENEMY.instantiate()
	enemy.core_data = enemy_type
	add_child(enemy)
	enemy.selected.connect(_on_enemy_selected)
	enemy_list.append(enemy)
	pass

func _on_enemy_selected(enemy:Enemy) -> void:
	enemy_selected.emit(enemy)
	pass
