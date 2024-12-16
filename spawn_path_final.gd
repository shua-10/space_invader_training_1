extends Path2D

@onready var timer: Timer = %Timer

signal enemy_spawned
signal fast_enemy_spawned
signal carrier_spawned
signal enemy_died
signal fast_enemy_died
signal carrier_died

func _ready() -> void:
	pass

func spawn_enemy():
	var new_enemy = preload("res://Scenes/enemy.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_enemy.global_position = %PathFollow2D.global_position
	get_parent().add_child(new_enemy)
	
	Game_Data.enemy_counter()
	

func spawn_fast_enemy():
	var new_enemy = preload("res://Scenes/fast_enemy.tscn").instantiate()
	
	%PathFollow2D.progress_ratio = randf()
	new_enemy.global_position = %PathFollow2D.global_position
	get_parent().add_child(new_enemy)
	fast_enemy_spawned.emit()
	
	Game_Data.fast_enemy_counter()

func spawn_carrier_enemy():
	var new_enemy = preload("res://Scenes/carrier_ship.tscn").instantiate()
	
	%spawnpathfollow.progress_ratio = randf()
	new_enemy.global_position = %spawnpathfollow.global_position
	get_parent().add_child(new_enemy)
	carrier_spawned.emit()
	
	Game_Data.carrier_counter()

func on_enemy_died():
	Game_Data.enemy_death()
func on_fast_enemy_died():
	Game_Data.fast_enemy_death()
func on_carrier_died():
	Game_Data.carrier_death()
