extends Node2D

@export var health = 5
@onready var level_complete = false
@export var Wave: WaveManager
var enemy_spawned: int = 0
var fast_enemy_spawned: int = 0
var carrier_spawned: int = 0



func _on_hurt_zone_body_entered(body: Node2D) -> void:
	health -= 1
	print (health)
	body.queue_free()
	if health == 0:
		print("game over")
		Global.game_over = true


func _ready() -> void:
	print(Wave.total_limit,enemy_spawned)

func _physics_process(delta: float) -> void:
	var total_enemy_count: int
	total_enemy_count = enemy_spawned + fast_enemy_spawned + carrier_spawned
	if Wave.total_limit == total_enemy_count:
		level_complete = true
		level_change()
	
func _process(delta: float) -> void:
	pass
	
func level_change():
	%Level_change_timer.start()
	if level_complete == true:
		%UpgradeSelector.visible = true
		

func _on_despawn_left_body_entered(body: Node2D) -> void:
	body.queue_free()


func _on_despawn_right_body_entered(body: Node2D) -> void:
	body.queue_free()


func _on_level_change_timer_timeout() -> void:
	level_complete = false
	Wave.current_wave += 1
	Wave.new_wave()
	Wave.wave_change()
	%Level_change_timer.stop()



func _on_enemy_spawn_path_enemy_spawned() -> void:
	enemy_spawned += 1

func _on_enemy_spawn_path_fast_enemy_spawned() -> void:
	fast_enemy_spawned += 1

func _on_enemy_spawn_path_carrier_spawned() -> void:
	carrier_spawned += 1
