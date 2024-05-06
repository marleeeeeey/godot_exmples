extends Sprite2D

var speed = 400
var angular_speed = PI

func _init() -> void:
	print("Hello, world")

func _process(delta: float) -> void:

	# Calculate the rotation
	var direction = 0
	if Input.is_action_pressed("ui_left"):
		direction = -1
	if Input.is_action_pressed("ui_right"):
		direction = 1
	rotation += direction * angular_speed * delta

	# Calculate the velocity
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity += Vector2.UP.rotated(rotation) * speed

	# Move the sprite
	position += velocity * delta

func _on_button_pressed() -> void:
	# Toggle the processing
	set_process(not is_processing())
