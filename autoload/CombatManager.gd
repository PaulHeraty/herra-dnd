extends Node

var turn_order: Array[ICombatEntity] = []

func turn_loop() -> void:
	GameLog.add_entry("Beginning turn...\n")
	turn_order.clear()
	determine_initiative_order()
	
	for actor in turn_order:
		if actor.is_alive == false:
			continue
		GameLog.add_entry("\n" + actor.entity_name + "'s turn\n")
		# Select target
		var target:ICombatEntity = select_target(actor)
		if target == null:
			GameLog.add_entry("[color=yellow]All of one side are DEAD![/color]\n")
			return
		GameLog.add_entry(actor.entity_name + " is attacking " + target.entity_name + "\n")
		await GameLog.advance
		make_attack(actor, target)
	GameLog.add_entry("End of turn...")
	pass

func select_target(actor: ICombatEntity) -> ICombatEntity:
	if actor.entity_type == actor.ENTITY_TYPE.PLAYER:
		return get_first_enemy()
	else:
		return get_player_target()

func get_first_enemy() -> ICombatEntity:
	var remaining_enemies: Array[ICombatEntity] = []
	for actor in turn_order:
		if actor.entity_type == actor.ENTITY_TYPE.ENEMY and actor.is_alive:
			return actor
	return null

func get_player_target() -> ICombatEntity:
	var remaining_players: Array[ICombatEntity] = []
	for actor in turn_order:
		if actor.entity_type == actor.ENTITY_TYPE.PLAYER and actor.is_alive: 
			remaining_players.append(actor)
	var target = randi_range(0, remaining_players.size()-1)
	return remaining_players[target]
	
func determine_initiative_order() -> void:
	# make a DEX roll (inc dex mod) per mob/PC
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
	
func _sort_by_initiative(a: ICombatEntity, b: ICombatEntity) -> bool:
	return a.initiative > b.initiative  # sort descending
	
func _print_turn_order():
	GameLog.add_entry("[color=yellow]Order of action is:[/color]\n")
	for actor in turn_order:
		GameLog.add_entry(actor.entity_name + " => " + str(actor.initiative) + ", ")
	GameLog.add_entry("\n")
	
func make_attack(attacker: ICombatEntity, target:ICombatEntity) -> void:
	# attack roll
	var ac = 0
	if target.entity_type == target.ENTITY_TYPE.ENEMY:
		ac = target.core_data.ac
	else:
		ac = target.core_data.ac
	var dmg: Dictionary = Rules.attack_roll(attacker, ac)
	
	# death checks
	for key in dmg.keys():
		var dmg_type: DamageComponent.DAMAGE_TYPE = key
		var dmg_amount: int = dmg[key]
		target.take_damage(dmg_type, dmg_amount)
	pass
