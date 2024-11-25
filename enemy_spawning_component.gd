extends Node2D
class_name EnemySpawner

var rng = RandomNumberGenerator.new()

@export var spawn_path: PathFollow2D
@export var spawn_timer: Timer
@export var max_enemy_spawned: float
var enemies_spawned: float

enum Enemies {
	STANDARD, #put in actual scene path possibly??
	FAST,
	TANK
}


func _ready() -> void:
	enemies_spawned = 0


func spawn_enemy():
	var new_enemy = preload("res://Scenes/enemy.tscn").instantiate()
	var enemy_spawn_limit = 3
	var enemies_spawned = 1
	
	
	%spawnpathfollow.progress_ratio = randf()
	new_enemy.global_position = %spawnpathfollow.global_position
	add_child(new_enemy)
