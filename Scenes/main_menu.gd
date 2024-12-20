extends Control





func _on_start_new_button_pressed() -> void:
	visible = false
	get_tree().paused = false


func _on_load_button_pressed() -> void:
	%SaverLoader.load_game()
	visible = false
	get_tree().paused = false


func _on_quit_button_pressed() -> void:
	get_tree().quit()
