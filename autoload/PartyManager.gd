extends Node

signal player_selected(player)

const PLAYER_CHARACTER = preload("res://characters/PlayerCharacter.tscn")
const PLAYER1: Resource = preload("res://characters/player_chars/Dunk.tres")
const PLAYER2: Resource = preload("res://characters/player_chars/Healz.tres")
const PLAYER3: Resource = preload("res://characters/player_chars/Ranga.tres")
const PLAYER4: Resource = preload("res://characters/player_chars/Merlin.tres")
const PLAYER5: Resource = preload("res://characters/player_chars/Defty.tres")

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
	get_tree().get_root().get_node("/root/Main/Party").add_child(player)
	player.selected.connect(_on_player_selected)
	party.append(player)
	pass

func setup_party() -> void:
	for p:PlayerCharacter in get_tree().get_root().get_node("/root/Main/Party").get_children():
		var sts = p.stats
		var c_type = p.core_data.class_type
		var pb = p.proficiency_bonus
		p.saving_throws.set_saving_throws(c_type, sts, pb)
		p.skills.set_skills(p)
	pass

func _on_player_selected(player:PlayerCharacter) -> void:
	player_selected.emit(player)
	pass

func award_xp(xp: int) -> void:
	var num_players: int = PartyManager.party.size()
	var individual_xp: int = int(xp / num_players)
	GameLog.add_entry("[color=yellow]Players get " + str(individual_xp) + " xp each![/color]\n")
	for p in PartyManager.party:
		p.award_xp(individual_xp)
