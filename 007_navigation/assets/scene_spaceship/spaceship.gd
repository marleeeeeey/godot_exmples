extends CharacterBody2D

@export var speed = 300


func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		# World2D - holds all components of a 2D world, such as a canvas and a physics space.
		var map = get_world_2d().navigation_map

		# Set the point to navigate to.
		var closest_point_on_nav_map = NavigationServer2D.map_get_closest_point(map, event.position)
		$NavigationAgent2D.target_position = closest_point_on_nav_map


func _physics_process(delta: float) -> void:
	if $NavigationAgent2D.is_navigation_finished():
		return

	# Calculate the next path position.
	var next_path_position = $NavigationAgent2D.get_next_path_position()

	# Rotate towards the next path position. X axis is the forward direction.
	look_at(next_path_position)

	# Calc velocity towards the next path position.
	var diff = next_path_position - global_position
	var direction = diff.normalized()
	velocity = direction * speed

	# Move the character.
	move_and_slide()
