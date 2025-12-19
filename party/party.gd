class_name Party extends CharacterBody2D

signal DirectionChanged(new_direction: Vector2)

@onready var sprite: Sprite2D = $Sprite2D

var move_speed: float = 50.0

var cardinal_direction : Vector2 = Vector2.DOWN
const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]
var direction : Vector2 = Vector2.ZERO

func _ready() -> void:
	PartyManager.map_team = self
	sprite.visible = false
	pass
	
func _process(_delta: float) -> void:
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	).normalized()
	
	var direction_id: int = int( round((direction + cardinal_direction * 0.1).angle() / TAU * DIR_4.size()))
	var new_direction: Vector2 = DIR_4[direction_id]
	cardinal_direction = new_direction
	
	velocity = direction * move_speed

	
func _physics_process(_delta: float) -> void:
	move_and_slide()
