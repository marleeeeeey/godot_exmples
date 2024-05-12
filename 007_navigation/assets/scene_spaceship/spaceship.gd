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
	var diff = target_position - global_position
	if diff.length() < 5:
		return

	var direction = (target_position - global_position).normalized()
	velocity = direction * SPEED
	move_and_slide()
