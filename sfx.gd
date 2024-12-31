extends Node
class_name SFX

@export var explosion_sound: AudioStreamPlayer2D
@export var engine: AudioStreamPlayer2D
@export var button_press: AudioStreamPlayer2D

func play_explosion():
	explosion_sound.pitch_scale = randf_range(0.85, 1.15)
	explosion_sound.play()

func play_engine():
	engine.pitch_scale = randf_range(0.25,0.40)
	engine.play()

func play_button_press():
	button_press.pitch_scale = randf_range(0.85, 1.15)
	button_press.play()
