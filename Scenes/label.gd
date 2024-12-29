extends Label


func _process(delta: float) -> void:
	text = str((round(%rapid_fire_cooldown.time_left)))
	
