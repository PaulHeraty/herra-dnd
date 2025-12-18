extends Node

signal player_selected(player)

const PARTY = preload("res://party/Party.tscn")
const PARTY_HIRES = preload("res://party/party_hiRes.tscn")
const PLAYER_CHARACTER = preload("res://characters/PlayerCharacter.tscn")
const PLAYER1: Resource = preload("res://characters/player_chars/Dunk.tres")
const PLAYER2: Resource = preload("res://characters/player_chars/Healz.tres")
const PLAYER3: Resource = preload("res://characters/player_chars/Ranga.tres")
const PLAYER4: Resource = preload("res://characters/player_chars/Merlin.tres")
const PLAYER5: Resource = preload("res://characters/player_chars/Defty.tres")

var map_team: Party
var map_team_hires : PartyHiRes
var map_team_spawned: bool = false

var party: Array[PlayerCharacter] = []

func _ready() -> void:
	add_map_team_hires_instance()
	add_players_for_combat()
	await  get_tree().create_timer(0.2).timeout
	#map_team_spawned = true

func add_map_team_hires_instance() -> void:
	map_team_hires = PARTY_HIRES.instantiate()
	add_child(map_team_hires)
	pass
	
func spawn_player(parent_node) -> Party:
	var map_team = PARTY.instantiate()
	parent_node.add_child(map_team)
	map_team_spawned = true
	return map_team 
	
func add_players_for_combat() -> void:
	party.clear()
	add_player_combat_instance(PLAYER1)
	add_player_combat_instance(PLAYER2)
	add_player_combat_instance(PLAYER3)
	add_player_combat_instance(PLAYER4)
	add_player_combat_instance(PLAYER5)
	
func add_player_combat_instance(toon: Resource) -> void:
	var player = PLAYER_CHARACTER.instantiate()
	player.core_data = toon
	#get_tree().get_root().get_node("/root/Main/Party").add_child(player)
	add_child(player)
	player.selected.connect(_on_player_selected)
	party.append(player)
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

func set_map_team_position(_new_pos: Vector2) -> void:
	map_team.global_position = _new_pos
	pass

func set_as_parent(_p : Node2D) -> void:
	if map_team.get_parent():
		map_team.get_parent().remove_child(map_team)
	_p.add_child(map_team)
	
func unparent_player(_p: Node2D) -> void:
	_p.remove_child(map_team)
