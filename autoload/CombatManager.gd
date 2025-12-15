extends Node

signal player_action_chosen

var turn_order: Array[CombatEntity] = []
var target: CombatEntity = null
var current_actor: CombatEntity = null
var players_alive: bool
var enemies_alive: bool
var combat_over: bool = false
var chosen_spell: Spell = null

func _ready() -> void:
	SpellBook.spell_selected.connect(_on_spell_selected)
	SpellBook.spellbook_cancelled.connect(_on_spell_cancelled)
	EnemyManager.enemy_selected.connect(_on_enemy_selected)
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("show_spell_book"):
		if SpellBook.is_shown == false:
			SpellBook.show_spell_book(current_actor)
		else:
			SpellBook.hide_spell_book()
		get_viewport().set_input_as_handled()
	pass
		
func enter_combat() -> void:
	players_alive = true
	enemies_alive = true
	combat_over = false
	var num_enemies: int = EnemyManager.enemy_list.size()
	var num_players: int = PartyManager.party.size()
	GameLog.add_entry("Entering combat between " + str(num_players) + " players and " + str(num_enemies) + " enemies!\n")
	
	while players_alive and enemies_alive:
		await turn_loop()
	pass

func turn_loop() -> void:
	GameLog.add_entry("[color=yellow]Starting new turn...\n[/color]")
	turn_order.clear()
	determine_initiative_order()
	
	for actor in turn_order:
		target = null
		current_actor = actor
		chosen_spell = null
		check_party_alive()
		check_enemies_alive()
		
		if combat_over:
			GameLog.add_entry("Combat is over!!!")
			return
			
		if actor == null or actor.is_alive == false:
			print("HERE")
			continue
			
		GameLog.add_entry("\n" + actor.entity_name + "'s turn: ")
		
		if actor.entity_type == actor.ENTITY_TYPE.PLAYER:
			await handle_player_turn(actor)
		else:
			await perform_ai_action(actor)
		
		await get_tree().create_timer(0.5).timeout
	GameLog.add_entry("End of turn...\n\n")
	pass 

func handle_player_turn(actor: CombatEntity):
	GameLog.add_entry("Awaiting target selection or spell choice...\n")
	await player_action_chosen
		
	if chosen_spell:
		GameLog.add_entry("Selected spell: " + chosen_spell.name + "\n")
		await get_spell_target(chosen_spell)
		await actor.cast_spell(chosen_spell, target)
	elif target:
		await handle_melee_attack(actor)
	else:
		GameLog.add_entry("No action selected.\n")
	# Add other actions here
	pass

func handle_melee_attack(actor: CombatEntity):
	if actor.entity_type == actor.ENTITY_TYPE.ENEMY:
		get_random_player_target()
	#await select_target(actor)
	GameLog.add_entry(actor.entity_name + " is attacking " + target.entity_name + "\n")
	await make_attack(actor)
	pass

func perform_ai_action(actor: CombatEntity):
	# Right now it just performs a melee attack on a random player
	await GameLog.advance # wait for keypress
	handle_melee_attack(actor)
	pass

func get_spell_target(spell: Spell) -> void:
	if spell.spell_type == Spell.SPELLTYPE.DEFENSIVE:
		await chose_player_spell_target()
	elif spell.spell_type == Spell.SPELLTYPE.OFFENSIVE:
		await select_target_for_player_turn()
	pass

func check_party_alive() -> void:
	for p in PartyManager.party:
		if p.is_alive:
			players_alive = true
	if not players_alive:
		GameLog.add_entry("[color=red]All players are dead!\n")
		combat_over = true
	pass
	
func check_enemies_alive() -> void:
	if EnemyManager.enemy_list.size() > 0:
		enemies_alive = true
	else:
		enemies_alive = false
		GameLog.add_entry("[color=red]All enemies are dead!\n")
		combat_over = true
	pass

func select_target_for_player_turn():
	if enemies_alive == false:
		return
	GameLog.add_entry("[color=orange]Select a target.\n[/color]")
	var signal_args = await EnemyManager.enemy_selected
	target = signal_args
	pass

func chose_player_spell_target():
	GameLog.add_entry("[color=orange]Select a player target.\n[/color]")
	var signal_args = await PartyManager.player_selected
	GameLog.add_entry("[color=orange]Selected player: [/color]" + signal_args.entity_name + "\n")
	target = signal_args
	pass
	
func get_random_player_target() -> void:
	var remaining_players: Array[CombatEntity] = []
	for actor in turn_order:
		if actor == null:
			continue
		if actor.entity_type == actor.ENTITY_TYPE.PLAYER and actor.is_alive: 
			remaining_players.append(actor)
	var target_index = randi_range(0, remaining_players.size()-1)
	target = remaining_players[target_index]
	pass
	
func determine_initiative_order() -> void:
	# make a DEX roll (inc dex mod) per mob/PC
	GameLog.add_entry("Rolling for initiative...\n")
	for player in PartyManager.party:
		if player.is_alive:
			player.roll_initiative()
			turn_order.append(player)
		
	for monster in EnemyManager.enemy_list:
		if monster.is_alive:
			monster.roll_initiative()
			turn_order.append(monster)
		
	turn_order.sort_custom(_sort_by_initiative)
	_print_turn_order()
	pass
	
func _sort_by_initiative(a: CombatEntity, b: CombatEntity) -> bool:
	return a.initiative > b.initiative  # sort descending
	
func _print_turn_order():
	GameLog.add_entry("[color=yellow]Order of action is:[/color]\n")
	for actor in turn_order:
		GameLog.add_entry(actor.entity_name + " => " + str(actor.initiative) + ", ")
	GameLog.add_entry("\n")
	pass
	
func make_attack(attacker: CombatEntity) -> void:
	# attack roll
	var ac = 0
	if target.entity_type == target.ENTITY_TYPE.ENEMY:
		ac = target.get_ac()
	else:
		ac = target.get_ac()
	var dmg: Dictionary = Rules.attack_roll(attacker, ac)
	
	# death checks
	for key in dmg.keys():
		var dmg_type: DamageComponent.DAMAGE_TYPE = key
		var dmg_amount: int = dmg[key]
		# Need await here to ensure that enemy is correctly killed as needed
		await target.take_damage(dmg_type, dmg_amount)
	pass

func _on_spell_selected(spell: Spell) -> void:
	chosen_spell = spell
	player_action_chosen.emit()
	pass
	
func _on_enemy_selected(selected_enemy: CombatEntity) -> void:
	target = selected_enemy
	player_action_chosen.emit()
	pass

func _on_spell_cancelled() -> void:
	chosen_spell = null
	pass
