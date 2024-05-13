extends CharacterBody2D

@export var speed: int = 300
@export var jump_velocity: int = -400
@export var gravity_koef: float = 1.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta * gravity_koef

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	# Update the direcion of animation.
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	elif velocity.x > 0:
		$AnimatedSprite2D.flip_h = false

	# Update the animation.
	if is_on_floor():
		if velocity.x == 0:
			$AnimatedSprite2D.play("idle")
		else:
			$AnimatedSprite2D.play("walk")
	else:
		$AnimatedSprite2D.play("idle")

	move_and_slide()
