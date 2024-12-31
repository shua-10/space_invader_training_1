extends Control



func _on_start_new_button_pressed() -> void:
	visible = false
	Sfx.play_button_press()
	get_tree().paused = false


func _on_load_button_pressed() -> void:
	%SaverLoader.load_game()
	Sfx.play_button_press()
	visible = false
	get_tree().paused = false


func _on_quit_button_pressed() -> void:
	Sfx.play_button_press()
	get_tree().quit()
