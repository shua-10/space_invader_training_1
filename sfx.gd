extends Node
class_name SFX

@export var explosion_sound: AudioStreamPlayer2D
@export var button_press: AudioStreamPlayer2D
@export var player_engine: AudioStreamPlayer2D
@export var menu_switching: AudioStreamPlayer2D


func play_explosion():
	explosion_sound.pitch_scale = randf_range(0.70, 1.30)
	explosion_sound.play()

func play_engine():
	player_engine.play()

func play_button_press():
	button_press.pitch_scale = randf_range(0.85, 1.15)
	button_press.play()

func play_menu_switch():
	menu_switching.pitch_scale = randf_range(0.85, 1.15)
	menu_switching.play()
