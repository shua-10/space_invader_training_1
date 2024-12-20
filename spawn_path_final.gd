extends Path2D
class_name SpawnPath

@onready var timer: Timer = %Timer
var timer_min_value: float = 1
var timer_max_value: float = 2
@export var wave_manager: WaveManager
var current_enemy_count: int = 0
var current_fast_enemy_count: int = 0
var current_carrier_count: int = 0
var current_death_enemy_count: int = 0
var current_death_fast_enemy_count: int = 0
var current_death_carrier_count: int = 0
var total_count: int = 0
var total_death_count: int = 0
var counts:Array = [current_enemy_count,
current_fast_enemy_count, 
current_carrier_count,
current_death_enemy_count,
current_death_fast_enemy_count,
current_death_carrier_count,
total_count,
total_death_count,]

signal enemy_spawned
signal fast_enemy_spawned
signal carrier_spawned
signal enemy_died
signal fast_enemy_died
signal carrier_died

func _process(delta: float) -> void:
	calc_death_total()

func _ready() -> void:
	timer.wait_time = randf_range(timer_min_value, timer_max_value)

func spawn_enemy():
	var new_enemy = preload("res://Scenes/enemy.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_enemy.global_position = %PathFollow2D.global_position
	get_parent().add_child.call_deferred(new_enemy)
	
	Game_Data.enemy_counter()
	current_enemy_count += 1
	print(current_enemy_count, Game_Data.regular_enemy_spawned)
	new_enemy.died.connect(on_enemy_died)

func spawn_fast_enemy():
	var new_enemy = preload("res://Scenes/fast_enemy.tscn").instantiate()
	
	%PathFollow2D.progress_ratio = randf()
	new_enemy.global_position = %PathFollow2D.global_position
	get_parent().add_child.call_deferred(new_enemy)
	fast_enemy_spawned.emit()
	
	Game_Data.fast_enemy_counter()
	current_fast_enemy_count += 1
	
	new_enemy.fast_enemy_died.connect(on_fast_enemy_died)
func spawn_carrier_enemy():
	var new_enemy = preload("res://Scenes/carrier_ship.tscn").instantiate()
	
	%spawnpathfollow.progress_ratio = randf()
	new_enemy.global_position = %spawnpathfollow.global_position
	get_parent().add_child.call_deferred(new_enemy)
	carrier_spawned.emit()
	
	Game_Data.carrier_counter()
	current_carrier_count += 1
	
	connect("carrier_died", on_carrier_died())

func calc_death_total():
	total_death_count = current_death_enemy_count + current_death_fast_enemy_count + current_death_carrier_count
	

func on_enemy_died():
	Game_Data.enemy_death()
	current_death_enemy_count += 1
	print("Death Count",current_death_enemy_count,"  ","Death Limit", wave_manager.wave_data.wave_death_limit)
	
func on_fast_enemy_died():
	Game_Data.fast_enemy_death()
	current_death_fast_enemy_count += 1
func on_carrier_died():
	Game_Data.carrier_death()
	current_death_carrier_count += 1


func _on_wave_manager_enemy_picked() -> void:
	spawn_enemy()


func _on_wave_manager_fast_enemy_picked() -> void:
	spawn_fast_enemy()


func _on_wave_manager_carrier_picked() -> void:
	spawn_carrier_enemy()


func _on_timer_timeout() -> void:
	wave_manager.enemy_picker()
