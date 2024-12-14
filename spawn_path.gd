extends Path2D


@onready var spawn_path_follow = %spawnpathfollow
@export var timers: Array[Timer]
@export var level_complete_check_timer: Timer
@export var timer_min: float
@export var timer_max: float
@export var wave_manager: WaveManager
@export var level: Level

var enemy_death_count: int = 0
var fast_enemy_death_count: int = 0
var carrier_death_count: int = 0

signal enemy_spawned
signal fast_enemy_spawned
signal carrier_spawned
signal enemy_died
signal fast_enemy_died
signal carrier_died


func _ready() -> void:
	
	for timer in timers:
		timer.wait_time = randf_range(timer_min,timer_max)
		timer.start()
	
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

	new_enemy.fast_enemy_died.connect(on_fast_enemy_died)
func spawn_carrier_enemy():
	var new_enemy = preload("res://Scenes/carrier_ship.tscn").instantiate()
	
	%spawnpathfollow.progress_ratio = randf()
	new_enemy.global_position = %spawnpathfollow.global_position
	get_parent().add_child(new_enemy)
	carrier_spawned.emit()

	new_enemy.carrier_died.connect(on_carrier_died)
	
func _on_enemy_spawn_timer_timeout() -> void:
	if level.level_complete == false:
		if wave_manager.regular_enemy_limit != enemy_death_count:
			wave_manager.enemy_picker()
		elif wave_manager.regular_enemy_limit == enemy_death_count:
			pass
	if level.level_complete == true:
		pass
		
func _on_fast_enemy_spawner_timeout() -> void:
	if level.level_complete == false:
		if wave_manager.fast_enemy_limit != fast_enemy_death_count:
			wave_manager.enemy_picker()
		elif wave_manager.fast_enemy_limit == fast_enemy_death_count:
			pass
	if level.level_complete == true:
		pass

func _on_carrier_timer_timeout() -> void:
	if level.level_complete == false:
		if wave_manager.carrier_enemy_limit != carrier_death_count:
			wave_manager.enemy_picker()
		elif wave_manager.carrier_enemy_limit == carrier_death_count:
			return
	if level.level_complete == true:
		return

func _on_wave_manager_enemy_picked() -> void:
	spawn_enemy()

func _on_wave_manager_fast_enemy_picked() -> void:
	spawn_fast_enemy()

func _on_wave_manager_carrier_picked() -> void:
	spawn_carrier_enemy()

func on_enemy_died():
	enemy_death_count = enemy_death_count + 1
	print(enemy_death_count)
func on_fast_enemy_died():
	fast_enemy_death_count = fast_enemy_death_count + 1
	print(fast_enemy_death_count)
func on_carrier_died():
	carrier_death_count += 1
	print(carrier_death_count)
	
func _on_level_complete_check_timer_timeout() -> void:
	var total_death_count:int = 0
	total_death_count = enemy_death_count + fast_enemy_death_count + carrier_death_count
	print(total_death_count)
	if total_death_count == wave_manager.total_limit:
		level.level_complete = true
		level.level_change()
		total_death_count = 0
		carrier_death_count = 0
		enemy_death_count = 0
		fast_enemy_death_count = 0
		
