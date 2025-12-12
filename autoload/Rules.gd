extends Node

func ability_check(ability_mod: int, dc: int) -> bool:
	var d: Dice = Dice.new()
	var roll = d.d20()
	GameLog.add_entry("Ability Check Roll: " + str(roll) + " + mod: " + str(ability_mod) + " vs. DC: " + str(dc) + "\n")
	if roll == 20:
		return true
	return roll + ability_mod >= dc

func skill_check(skill_mod: int, dc: int) -> bool:
	var d: Dice = Dice.new()
	var roll = d.d20()
	GameLog.add_entry("Skill Check Roll: " + str(roll) + " + mod: " + str(skill_mod) + " vs. DC: " + str(dc) + "\n")
	if roll == 20:
		return true
	return roll + skill_mod >= dc
	
func saving_throw_check(st_mod: int, dc: int) -> bool:
	var d: Dice = Dice.new()
	var roll = d.d20()
	GameLog.add_entry("Saving Throw Roll: " + str(roll) + " + mod: " + str(st_mod) + " vs. DC: " + str(dc) + "\n")
	if roll == 20:
		return true
	return roll + st_mod >= dc

func attack_roll(p: CombatEntity, ac: int) -> Dictionary:
	var atk_mod: int = 0
	var critical_hit: bool = false
	var critical_miss: bool = false
	var prof_bonus: int = p.proficiency_bonus
	var weapons = p.equipped_weapons
	var damage: Dictionary = {}
	var d: Dice = Dice.new()
	
	for w: Weapon in weapons:
		if w.properties.has("Finesse"):
			atk_mod = max(p.stats.strength_mod, p.stats.dexterity_mod)
		elif w.weapon_type == Weapon.WEAPON_TYPE.SIMPLE_RANGED or w.weapon_type == Weapon.WEAPON_TYPE.MARTIAL_RANGED:
			atk_mod = p.stats.dexterity_mod
		else:
			atk_mod = p.stats.strength_mod
			
		var roll = d.d20()
		GameLog.add_entry("Attack Roll: " + str(roll) + " + atk_mod: " 
			+ str(atk_mod) + " + pb: " + str(prof_bonus) + " vs. AC: " + str(ac) + "\n")
		if roll == 1:
			GameLog.add_entry("[color=red]Critical miss![/color]\n")
			p.attack_miss()
		if roll == 20:
			critical_hit = true
			GameLog.add_entry("[color=orange]Critical hit![/color]\n")
			
		if (roll + atk_mod + prof_bonus >= ac or critical_hit) and not critical_miss:
			GameLog.add_entry("[color=green]" + p.core_data.name + " hits with " + w.name + "[/color]\n")
			p.attack_hit()
			damage = get_weapon_damage(w, damage, critical_hit)
		else:
			p.attack_miss()
			GameLog.add_entry("[color=red]" + p.core_data.name + " misses with " + w.name + "[/color]\n")
	return damage
	
func get_weapon_damage(weapon: Weapon, damage: Dictionary, critical: bool) -> Dictionary:
	var result = damage
	var d: Dice = Dice.new()
	for dmg in weapon.damage:
		var roll = d.roll(dmg.dice_count, dmg.dice_sides)
		if critical:
			roll += d.roll(dmg.dice_count, dmg.dice_sides)
		GameLog.add_entry("Damage: " + str(roll) + "\n")
		if result.has(dmg.damage_type):
			result[dmg.damage_type] += roll
		else:
			result[dmg.damage_type] = roll
	return result
