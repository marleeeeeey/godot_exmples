extends Sprite2D

var speed = 400
var angular_speed = PI

func _init() -> void:
	print("Hello, world")

func _process(delta: float) -> void:
	var direction = 0
	if Input.is_action_pressed("ui_left"):
		direction = -1
	if Input.is_action_pressed("ui_right"):
		direction = 1
	rotation += direction * angular_speed * delta

	var velocity = Vector2.UP.rotated(rotation) * speed
	position += velocity * delta
