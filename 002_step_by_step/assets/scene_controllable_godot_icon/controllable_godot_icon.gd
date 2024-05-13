extends Sprite2D

# Declare a signal called health_depleted
signal health_depleted(old_health: int, new_health: int)
var health = 10

var speed = 400
var angular_speed = PI

func _init() -> void:
	print("Hello, world")

func _ready() -> void:
	# Example of connecting a signal in runtime:
	# We want to connect the signal when the scene is instantiated,
	# and we can do that using the Node._ready() built-in function,
	# which is called automatically by the engine when a node is fully instantiated.
	var timer = get_node("Timer") as Timer
	timer.timeout.connect(_on_timer_timeout)

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

func _on_timer_timeout():
	visible = not visible

func take_damage(amount):
	health -= amount
	if health <= 0:
		# Emit the signal when the health is depleted
		health_depleted.emit()
