extends Node

class_name WaveManager
signal enemy_picked
signal fast_enemy_picked
signal carrier_picked
@export var regular_enemy_limit: float
@export var fast_enemy_limit: float
@export var carrier_enemy_limit: float
@export var regular_enemy_count: float
@export var fast_enemy_count: float
@export var carrier_enemy_count: float

@export var regular_enemy_prob: float
@export var fast_enemy_prob: float
@export var carrier_enemy_prob: float
var current_wave: float


func _ready() -> void:
	current_wave = 1
	new_wave()
	wave_change()
	
func new_wave():
	regular_enemy_count = 1
	fast_enemy_count = 1
	carrier_enemy_count = 1

func enemy_picker():
	var enemy_picker_rng = Global.rng.randf_range(0.1, 1)
	if regular_enemy_count == regular_enemy_limit:
		remove_user_signal("enemy_picked")
	if fast_enemy_count == fast_enemy_limit:
		remove_user_signal("fast_enemy_picked")
	if carrier_enemy_count == carrier_enemy_limit:
		remove_user_signal("carrier_enemy_picked")
		
	if regular_enemy_prob > enemy_picker_rng:
		emit_signal("enemy_picked")
	if fast_enemy_prob > enemy_picker_rng:
		emit_signal("fast_enemy_picked")
	if carrier_enemy_prob > enemy_picker_rng:
		emit_signal("carrier_picked")
	
	print("picker rng",   enemy_picker_rng)

func wave_change():
	print("wave",   current_wave)
	
	if current_wave == 1:
		regular_enemy_prob = 1
		regular_enemy_limit = 10

	if current_wave == 2:
		regular_enemy_prob = 0.8
		fast_enemy_prob = 0.2
		regular_enemy_limit = 10
		fast_enemy_limit = 2
	
