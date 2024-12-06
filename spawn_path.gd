extends Path2D


@onready var spawn_path_follow = %spawnpathfollow
@export var spawn_timer: Timer
@export var timer_min: float
@export var timer_max: float
@export var wave_manager: WaveManager
@export var level: Level

var enemy_death_count: int = 0

signal enemy_spawned
signal fast_enemy_spawned
signal carrier_spawned
signal enemy_died
signal fast_enemy_died
signal carrier_died


func _ready() -> void:
	spawn_timer.wait_time = randf_range(timer_min,timer_max)
	spawn_timer.start()
	
func spawn_enemy():
	var new_enemy = preload("res://Scenes/enemy.tscn").instantiate()
	%spawnpathfollow.progress_ratio = randf()
	new_enemy.global_position = %spawnpathfollow.global_position
	get_parent().add_child(new_enemy)
	enemy_spawned.emit()
	
	new_enemy.died.connect(on_enemy_died)
func spawn_fast_enemy():
	var new_enemy = preload("res://Scenes/fast_enemy.tscn").instantiate()
	
	%spawnpathfollow.progress_ratio = randf()
	new_enemy.global_position = %spawnpathfollow.global_position
	get_parent().add_child(new_enemy)
	fast_enemy_spawned.emit()


func spawn_carrier_enemy():
	var new_enemy = preload("res://Scenes/carrier_ship.tscn").instantiate()
	
	%spawnpathfollow.progress_ratio = randf()
	new_enemy.global_position = %spawnpathfollow.global_position
	get_parent().add_child(new_enemy)
	carrier_spawned.emit()


func _on_enemy_spawn_timer_timeout() -> void:
	if level.level_complete == false:
		wave_manager.enemy_picker()
	if level.level_complete == true:
		return


func _on_wave_manager_enemy_picked() -> void:
	spawn_enemy()


func _on_wave_manager_fast_enemy_picked() -> void:
	spawn_fast_enemy()


func _on_wave_manager_carrier_picked() -> void:
	spawn_carrier_enemy()

func on_enemy_died():
	enemy_death_count =  enemy_death_count + 1
	print(enemy_death_count)
	if enemy_death_count == wave_manager.total_limit:
		level.level_complete = true
		level.level_change()
		#set up to infinitely count waves but won't change wave conditions from
		#wave manager
		enemy_death_count = 0
