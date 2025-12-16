class_name Weapon extends Resource

enum WEAPON_TYPE {SIMPLE_MELEE, SIMPLE_RANGED, MARTIAL_MELEE, MARTIAL_RANGED}

@export var name: String = ""
@export var weapon_type: WEAPON_TYPE = WEAPON_TYPE.SIMPLE_MELEE
@export var cost: int = 0
@export var damage: Array[DamageComponent] = []
@export var weight: int = 0
@export var properties: Array[String] = []
@export var attack_sound_path: String = ""

var attack_sound: AudioStream = null

func _init() -> void:
	if attack_sound_path != "":
		attack_sound = load(attack_sound_path)
