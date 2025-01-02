extends Node
class_name SFX

@export var explosion_sound: AudioStreamPlayer2D
@export var button_press: AudioStreamPlayer2D
@export var player_engine: AudioStreamPlayer2D
@export var menu_main_screen: AudioStreamPlayer2D
@export var game_music: AudioStreamPlayer2D


func play_explosion():
	explosion_sound.pitch_scale = randf_range(0.70, 1.30)
	explosion_sound.play()

func play_engine():
	player_engine.play()

func play_button_press():
	button_press.pitch_scale = randf_range(0.85, 1.15)
	button_press.play()

func play_menu_main_screen():
	menu_main_screen.play()

func play_game_music():
	game_music.play()
