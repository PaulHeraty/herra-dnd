extends Node

var turn_order: Array[CombatEntity] = []
var target: CombatEntity = null
var players_alive: bool
var enemies_alive: bool
var combat_over: bool = false

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
		check_party_alive()
		check_enemies_alive()
		
		if combat_over:
			GameLog.add_entry("Combat is over!!!")
			return
			
		if actor == null or actor.is_alive == false:
			print("HERE")
			continue
			
		GameLog.add_entry("\n" + actor.entity_name + "'s turn: ")
		
		# Choose action (attack, cast, etc)
		if actor.entity_name == "Healz":
			SpellMenu.open(actor.known_spells)
			var chosen_spell = await SpellMenu.spell_selected
			GameLog.add_entry("Selected spell: " + chosen_spell.name + "\n")
			await chose_player_spell_target()
			await actor.cast_spell(chosen_spell, target)			
		elif actor.entity_name == "Merlin":
			SpellMenu.open(actor.known_spells)
			var chosen_spell = await SpellMenu.spell_selected
			GameLog.add_entry("Selected spell: " + chosen_spell.name + "\n")
			await select_target_for_player_turn()
			await actor.cast_spell(chosen_spell, target)
		else:
			# Select target
			await select_target(actor)
			GameLog.add_entry(actor.entity_name + " is attacking " + target.entity_name + "\n")
			if actor.entity_type == actor.ENTITY_TYPE.ENEMY:
				await GameLog.advance # wait for keypress
			await make_attack(actor)
		
		await get_tree().create_timer(0.5).timeout
	GameLog.add_entry("End of turn...\n\n")
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

func select_target(actor: CombatEntity) -> void:
	if actor.entity_type == actor.ENTITY_TYPE.PLAYER:
		await select_target_for_player_turn()
	else:
		get_player_target()

#func get_first_enemy() -> ICombatEntity:
	#var _remaining_enemies: Array[ICombatEntity] = []
	#for actor in turn_order:
		#if actor.entity_type == actor.ENTITY_TYPE.ENEMY and actor.is_alive:
			#return actor
	#return null

func select_target_for_player_turn():
	if enemies_alive == false:
		return
	GameLog.add_entry("[color=orange]Select a target.\n[/color]")
	var signal_args = await EnemyManager.enemy_selected
	target = signal_args


func chose_player_spell_target():
	GameLog.add_entry("[color=orange]Select a player target.\n[/color]")
	var signal_args = await PartyManager.player_selected
	GameLog.add_entry("[color=orange]Selected player: [/color]" + signal_args.entity_name + "\n")
	target = signal_args
	
func get_player_target() -> void:
	var remaining_players: Array[CombatEntity] = []
	for actor in turn_order:
		if actor == null:
			continue
		if actor.entity_type == actor.ENTITY_TYPE.PLAYER and actor.is_alive: 
			remaining_players.append(actor)
	var target_index = randi_range(0, remaining_players.size()-1)
	target = remaining_players[target_index]
	
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
	
func make_attack(attacker: CombatEntity) -> void:
	# attack roll
	var ac = 0
	if target.entity_type == target.ENTITY_TYPE.ENEMY:
		ac = target.ac
	else:
		ac = target.ac
	var dmg: Dictionary = Rules.attack_roll(attacker, ac)
	
	# death checks
	for key in dmg.keys():
		var dmg_type: DamageComponent.DAMAGE_TYPE = key
		var dmg_amount: int = dmg[key]
		# Need await here to ensure that enemy is correctly killed as needed
		await target.take_damage(dmg_type, dmg_amount)
	pass
