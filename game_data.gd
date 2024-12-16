extends Node
class_name GameData

var regular_enemy_spawned: int = 0
var fast_enemy_spawned: int = 0
var carrier_enemy_spawned: int = 0
var regular_enemy_killed: int = 0
var fast_enemy_killed: int = 0
var carrier_enemy_killed: int = 0

var player_score: int = 0



func enemy_counter():
	regular_enemy_spawned += 1
	print("enemy spawned","  ",regular_enemy_spawned)
func enemy_death():
	regular_enemy_killed += 1

func fast_enemy_counter():
	fast_enemy_spawned += 1
func fast_enemy_death():
	fast_enemy_killed += 1

func carrier_counter():
	carrier_enemy_spawned += 1
func carrier_death():
	carrier_enemy_killed += 1
