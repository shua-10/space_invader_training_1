extends Control

var current_window_mode = 0
@export var show_stats_menu: Control
@onready var h_slider: HSlider = $PanelContainer/Panel/VBoxContainer/HSlider


func _process(delta: float) -> void:
	pass


func _ready() -> void:
	current_window_mode = Game_Data.current_window_mode
	h_slider.max_value = 0
	h_slider.min_value = -20
	h_slider.value = Sfx.game_music.volume_db

func _on_back_button_pressed() -> void:
	%pause_menu.visible = true
	visible = false
	Sfx.play_button_press()

func _on_display_options_item_selected(index: int) -> void:
	if index == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		current_window_mode = 0
		Sfx.play_button_press()
		
	if index == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		current_window_mode = 1
		Sfx.play_button_press()

func _on_option_button_item_selected(index: int) -> void:
	if index == 0:
		DisplayServer.window_set_size(Vector2(640,360))
		Sfx.play_button_press()
	if index == 1:
		DisplayServer.window_set_size(Vector2(1280,720))
		Sfx.play_button_press()
	


func _on_show_stats_pressed() -> void:
	show_stats_menu.visible = true
	Sfx.play_button_press()


func _on_h_slider_value_changed(value: float) -> void:
	Sfx.game_music.volume_db = value
	Sfx.explosion_sound.volume_db = value
