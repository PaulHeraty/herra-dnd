extends Node

const PLAYER_CHARACTER = preload("res://characters/PlayerCharacter.tscn")
#const PLAYER_CHARACTER = preload("res://core/ICombatEntity.tscn")
const PLAYER1: Resource = preload("res://characters/game_chars/Dunk.tres")
const PLAYER2: Resource = preload("res://characters/game_chars/Healz.tres")
const PLAYER3: Resource = preload("res://characters/game_chars/Ranga.tres")
const PLAYER4: Resource = preload("res://characters/game_chars/Merlin.tres")
const PLAYER5: Resource = preload("res://characters/game_chars/Defty.tres")

var party: Array[PlayerCharacter] = []

func _ready() -> void:
	add_players()
	
func add_players() -> void:
	party.clear()
	add_player_instance(PLAYER1)
	add_player_instance(PLAYER2)
	add_player_instance(PLAYER3)
	add_player_instance(PLAYER4)
	add_player_instance(PLAYER5)
	
func add_player_instance(toon: Resource) -> void:
	var player = PLAYER_CHARACTER.instantiate()
	player.core_data = toon
	get_tree().get_root().get_node("/root/PartyManager").add_child(player)
	party.append(player)
	pass

func setup_party() -> void:
	for p:PlayerCharacter in get_tree().get_root().get_node("/root/PartyManager").get_children():
		var sts = p.core_data.stats
		var c_type = p.core_data.class_type
		var pb = p.core_data.proficiency_bonus
		p.core_data.saving_throws.set_saving_throws(c_type, sts, pb)
		p.core_data.skills.set_skills(p)
	pass
