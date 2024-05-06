extends Area2D

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	#hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	# Calculate the player's movement vector.
	var changed_up_down = false
	var changed_left_right = false
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		changed_left_right = true
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		changed_left_right = true
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		changed_up_down = true
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		changed_up_down = true

	# Choose the correct animation and flip the sprite. Walk animation is used when moving diagonally.
	$AnimatedSprite2D.animation = "up" if velocity.y != 0 else "walk"

	# Flip the sprite if needed.
	if changed_left_right:
		$AnimatedSprite2D.flip_h = velocity.x < 0
	if changed_up_down:
		$AnimatedSprite2D.flip_v = velocity.y > 0

	# Manage the player's animation (and normalize the velocity vector).
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	# Move the player.
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
