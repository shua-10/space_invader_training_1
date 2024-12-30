extends Control

var current_window_mode = 0

func _ready() -> void:
	current_window_mode = Game_Data.current_window_mode

func _on_back_button_pressed() -> void:
	%pause_menu.visible = true
	visible = false
	

func _on_display_options_item_selected(index: int) -> void:
	if index == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		current_window_mode = 0
	if index == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		current_window_mode = 1

func _on_option_button_item_selected(index: int) -> void:
	if index == 0:
		DisplayServer.window_set_size(Vector2(640,360))
	if index == 1:
		DisplayServer.window_set_size(Vector2(1280,720))
