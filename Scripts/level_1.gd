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
	

func left_spawn_meteor():
	var new_meteor = preload("res://Scenes/meteor.tscn").instantiate()
	
	
	%Left_Meteor_Path.progress_ratio = randf()
	new_meteor.position = %Left_Meteor_Path.global_position
	new_meteor.vector_initial = Vector2(250,50)
	add_child(new_meteor)
	
	
func right_spawn_meteor():
	var right_new_meteor = preload("res://Scenes/meteor.tscn").instantiate()
	
	
	%Right_Meteor_Path.progress_ratio = randf()
	right_new_meteor.global_position = %Right_Meteor_Path.global_position
	right_new_meteor.vector_initial = Vector2(-250,50)
	add_child(right_new_meteor)
	
	
	
func _on_enemy_spawn_timer_timeout() -> void:
	if level_complete == false:
		spawn_enemy()
		enemies_spawned += 1
		
	if level_complete == true:
		print("level complete")
		%Enemy_Spawn_Timer.stop()
	


func _on_left_meteor_timer_timeout() -> void:
	if level_complete == false:
		left_spawn_meteor()
		
		

func _on_right_meteor_timer_timeout() -> void:
	if level_complete == false:
		right_spawn_meteor()
		print("started")





func _on_despawn_left_body_entered(body: Node2D) -> void:
	body.queue_free()


func _on_despawn_right_body_entered(body: Node2D) -> void:
	body.queue_free()
