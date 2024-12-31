extends Control
class_name  EndMenu



func _on_button_pressed() -> void:
	Sfx.play_button_press()
	get_tree().reload_current_scene()
	Engine.time_scale = 1.0
