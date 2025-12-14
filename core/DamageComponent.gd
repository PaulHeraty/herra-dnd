class_name DamageComponent extends Resource

enum DAMAGE_TYPE {BLUDGEONING, PIERCING, SLASHING, FORCE, RADIANT}

@export var dice_count: int = 1         # e.g. 2
@export var dice_sides: int = 6         # e.g. d6
@export var damage_type: DAMAGE_TYPE = DAMAGE_TYPE.BLUDGEONING
