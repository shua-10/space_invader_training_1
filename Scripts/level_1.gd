extends Node2D
class_name Level

@export var health = 5
@onready var level_complete = false
@export var Wave: WaveManager
@export var enemy_counter: Area2D


func _on_hurt_zone_body_entered(body: Node2D) -> void:
	health -= 1
	print (health)
	body.queue_free()
	if health == 0:
		print("game over")
		Global.game_over = true


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func _process(delta: float) -> void:
	pass
	
func level_start():
	%UpgradeSelector.visible = false
	get_tree().paused = false
	Wave.new_wave()
	Wave.wave_change()
	
func level_change():
	print("method called")
	get_tree().paused = true
	var enemy_in_game = enemy_counter.get_overlapping_bodies()
	for bodies in enemy_in_game:
		bodies.queue_free()
	%UpgradeSelector.visible = true
	

func _on_despawn_left_body_entered(body: Node2D) -> void:
	body.queue_free()


func _on_despawn_right_body_entered(body: Node2D) -> void:
	body.queue_free()





func _on_wave_manager_level_complete() -> void:
	level_change()
	level_complete = true
	


func _on_upgrade_selector_visibility_changed() -> void:
	if %UpgradeSelector.visible == false:
		level_start()
