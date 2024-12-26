extends Control




func _on_back_button_pressed() -> void:
	%pause_menu.visible = true
	visible = false


func _on_display_options_item_selected(index: int) -> void:
	if index == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if index == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_option_button_item_selected(index: int) -> void:
	if index == 0:
		DisplayServer.window_set_size(Vector2(640,360))
	if index == 1:
		DisplayServer.window_set_size(Vector2(1290,720))
