extends Node2D
class_name Level

@export var health = 5
@onready var level_complete = false
@export var Wave: WaveManager
@export var enemy_counter: Area2D
var enemy_spawned: int = 0
var fast_enemy_spawned: int = 0
var carrier_spawned: int = 0
var enemy_died: int = 0
var fast_enemy_died: int = 0
var carrier_died: int = 0

func _on_hurt_zone_body_entered(body: Node2D) -> void:
	health -= 1
	print (health)
	body.queue_free()
	if health == 0:
		print("game over")
		Global.game_over = true


func _ready() -> void:
	print(Wave.total_limit,"  ",enemy_spawned)

func _physics_process(delta: float) -> void:
	pass

func _process(delta: float) -> void:
	pass
	
	
func level_change():
	print("method called")
	get_tree().paused = true
	var enemy_in_game = enemy_counter.get_overlapping_bodies()
	for bodies in enemy_in_game:
		bodies.queue_free()
	if level_complete == true:
		print("level complete")
		%UpgradeSelector.visible = true
		

func _on_despawn_left_body_entered(body: Node2D) -> void:
	body.queue_free()


func _on_despawn_right_body_entered(body: Node2D) -> void:
	body.queue_free()


func _on_enemy_spawn_path_enemy_spawned() -> void:
	enemy_spawned += 1

func _on_enemy_spawn_path_fast_enemy_spawned() -> void:
	fast_enemy_spawned += 1

func _on_enemy_spawn_path_carrier_spawned() -> void:
	carrier_spawned += 1

func _on_enemy_spawn_path_enemy_died() -> void:
	enemy_died += 1
	print(enemy_died)


func _on_upgrade_selector_visibility_changed() -> void:
	if %UpgradeSelector.visible == false:
		level_complete = false
		get_tree().paused = false
		Wave.new_wave()
		Wave.wave_change()
