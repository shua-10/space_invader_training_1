extends Path2D


@onready var spawn_path_follow = %spawnpathfollow
@export var spawn_timer: Timer
@export var timer_min: float
@export var timer_max: float
@export var wave_manager: WaveManager

signal enemy_spawned
signal fast_enemy_spawned
signal carrier_spawned



func _ready() -> void:
	spawn_timer.wait_time = randf_range(timer_min,timer_max)
	
func spawn_enemy():
	var new_enemy = preload("res://Scenes/enemy.tscn").instantiate()
	%spawnpathfollow.progress_ratio = randf()
	new_enemy.global_position = %spawnpathfollow.global_position
	add_child(new_enemy)
	enemy_spawned.emit()

func spawn_fast_enemy():
	var new_enemy = preload("res://Scenes/fast_enemy.tscn").instantiate()
	
	%spawnpathfollow.progress_ratio = randf()
	new_enemy.global_position = %spawnpathfollow.global_position
	add_child(new_enemy)
	fast_enemy_spawned.emit()


func spawn_carrier_enemy():
	var new_enemy = preload("res://Scenes/carrier_ship.tscn").instantiate()
	
	%spawnpathfollow.progress_ratio = randf()
	new_enemy.global_position = %spawnpathfollow.global_position
	add_child(new_enemy)
	carrier_spawned.emit()


func _on_enemy_spawn_timer_timeout() -> void:
	wave_manager.enemy_picker()



func _on_wave_manager_enemy_picked() -> void:
	spawn_enemy()


func _on_wave_manager_fast_enemy_picked() -> void:
	spawn_fast_enemy()


func _on_wave_manager_carrier_picked() -> void:
	spawn_carrier_enemy()
