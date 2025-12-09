class_name PlayerCharacter extends ICombatEntity

#@export var player_name: String = ""
@export var core_data: Character

func _ready() -> void:
	core_data.speed = get_race_speed(core_data.race)
	core_data.current_hp = core_data.max_hp
	entity_name = core_data.name
	entity_type = ENTITY_TYPE.PLAYER
	set_ac()
	pass

func roll_initiative() -> void:
	var d: Dice = Dice.new()
	initiative = d.roll(1, 20) + core_data.stats.dexterity_mod
	GameLog.add_entry(core_data.name + " rolls " + str(initiative) + " initiative\n")

func take_damage(dmg_type: DamageComponent.DAMAGE_TYPE, dmg_amount: int) -> void:
	# Should be overridden
	GameLog.add_entry(entity_name + " taking " + str(dmg_amount) + " damage of type " + str(dmg_type) + "\n")
	core_data.current_hp -= dmg_amount
	GameLog.add_entry(entity_name + " has " + str(core_data.current_hp) + " left\n")
	if core_data.current_hp <= 0:
		GameLog.add_entry(entity_name + " is DEAD!!!!\n")
		core_data.is_alive = false
	pass
	
func set_ac() -> void:
	var ac = 0
	# First add armor AC and shield
	if core_data.equipped_armor.size() > 0:
		for a in core_data.equipped_armor:
			ac += a.ac
	else:
		ac = 10
	
	# Now add DEX mod 
	if core_data.equipped_armor.size() > 0:
		for a in core_data.equipped_armor:
			if a.armor_type == Armor.ARMOR_TYPE.LIGHT:
				ac += core_data.stats.dexterity_mod
			elif a.armor_type == Armor.ARMOR_TYPE.MEDIUM:
				ac += min(core_data.stats.dexterity_mod, 2)
	else:
		ac += core_data.stats.dexterity_mod
	
	core_data.ac = ac

func get_race_speed(race: Race.RaceType) -> int:
	match race:
		Race.RaceType.HUMAN:
			return 30
		Race.RaceType.DWARF:
			return 25
		Race.RaceType.HALFLING:
			return 25
		Race.RaceType.ELF:
			return 30
		_:
			return 0
