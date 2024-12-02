extends Node

class_name WaveManager

@export var regular_enemy_limit: float
@export var fast_enemy_limit: float = 0
@export var carrier_enemy_limit: float
@export var regular_enemy_count: float = 0
@export var fast_enemy_count: float
@export var carrier_enemy_count: float = 0

@export var regular_enemy_prob: float
@export var fast_enemy_prob: float
@export var carrier_enemy_prob: float
var current_wave: float


func _ready() -> void:
	current_wave = 1

func wave_change():
	if current_wave == 1:
		regular_enemy_prob = 100
		fast_enemy_prob = 0
		
