extends Node
class_name GameData

var regular_enemy_spawned: int = 0
var fast_enemy_spawned: int = 0
var carrier_enemy_spawned: int = 0
var regular_enemy_killed: int = 0
var fast_enemy_killed: int = 0
var carrier_enemy_killed: int = 0

var player_score: int = 0

var high_score: int = 0
var highest_wave: int = 1
var current_wave: int = 1
var current_score: int = 0

var enemy_score: int = 100
var fast_enemy_score: int = 50
var carrier_score: int = 500


func _process(delta: float) -> void:
	if current_score >= high_score:
		high_score = current_score

func enemy_counter():
	regular_enemy_spawned += 1
	
func enemy_death():
	regular_enemy_killed += 1
	current_score += enemy_score

func fast_enemy_counter():
	fast_enemy_spawned += 1
func fast_enemy_death():
	fast_enemy_killed += 1
	current_score += fast_enemy_score

func carrier_counter():
	carrier_enemy_spawned += 1
func carrier_death():
	carrier_enemy_killed += 1
	current_score += current_score
