extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var target_position = Vector2.ZERO

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
		target_position = event.position

func _physics_process(delta: float) -> void:
	move_and_slide()
