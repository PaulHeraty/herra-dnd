class_name Enemy extends ICombatEntity

@export var core_data: EnemyCore

func _ready() -> void:
	set_hp()
	GameLog.add_entry("Monster: " + core_data.name + " has " + str(core_data.current_hp) + " hit points\n" )
	entity_name = core_data.name
	entity_type = ENTITY_TYPE.ENEMY
	pass

func roll_initiative() -> void:
	var d: Dice = Dice.new()
	initiative = d.roll(1, 20) + core_data.stats.dexterity_mod
	GameLog.add_entry(core_data.name + " rolls " + str(initiative) + " initiative\n")
	pass
	
func set_hp() -> void:
	core_data.current_hp = calculate_hp(core_data.hit_dice)
	core_data.max_hp = core_data.current_hp 
	pass

func take_damage(dmg_type: DamageComponent.DAMAGE_TYPE, dmg_amount: int) -> void:
	# Should be overridden
	GameLog.add_entry(entity_name + " taking " + str(dmg_amount) + " damage of type " + str(dmg_type) + "\n")
	core_data.current_hp -= dmg_amount
	GameLog.add_entry(entity_name + " has " + str(core_data.current_hp) + " left\n")
	if core_data.current_hp <= 0:
		GameLog.add_entry(entity_name + " is DEAD!!!!\n")
		core_data.is_alive = false
	pass
	
func calculate_hp(hit_dice: HitDice) -> int:
	var d: Dice = Dice.new()
	var hps = d.roll(hit_dice.dice_count, hit_dice.dice_sides) + hit_dice.plus_amount
	return hps
