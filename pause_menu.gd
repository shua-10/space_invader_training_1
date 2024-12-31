extends Control
class_name PauseMenu



func _on_resume_button_pressed() -> void:
	visible = false
	Sfx.play_button_press()
	get_tree().paused = false
	

func _on_options_button_pressed() -> void:
	Sfx.play_button_press()
	%options_menu.visible = true
	visible = false


func _on_quit_button_pressed() -> void:
	Sfx.play_button_press()
	get_tree().reload_current_scene()
