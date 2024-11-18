extends Node2D

var health = 5
var level_complete = false
var enemy_spawn_limit = 3
var enemies_spawned = 0


func _on_hurt_zone_body_entered(body: Node2D) -> void:
	health -= 1
	print (health)
	body.queue_free()
	if health == 0:
		print("game over")
		Global.game_over = true
	
	

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	if enemies_spawned == enemy_spawn_limit:
		level_complete = true
		
	

func spawn_enemy():
	var new_enemy = preload("res://Scenes/enemy.tscn").instantiate()
	var enemy_spawn_limit = 3
	var enemies_spawned = 1
	
	
	%spawnpathfollow.progress_ratio = randf()
	new_enemy.global_position = %spawnpathfollow.global_position
	add_child(new_enemy)
	


func _on_enemy_spawn_timer_timeout() -> void:
	if level_complete == false:
		spawn_enemy()
		enemies_spawned += 1
		
	if level_complete == true:
		print("level complete")
		$Enemy_Spawn_Timer.stop()
	
