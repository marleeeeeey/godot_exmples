extends Sprite2D

@export var debug_text = ""


func _ready() -> void:
	$Timer.start()


func _process(delta: float) -> void:
	$PosLabel.text = "l: %s g: %s" % [position, global_position]
	$DebugLabel.text = debug_text


func _on_timer_timeout() -> void:
	queue_free()
