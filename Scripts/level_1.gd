extends Node2D

var health = 5


func _on_hurt_zone_body_entered(body: Node2D) -> void:
	health -= 1
	print (health)
	body.queue_free()
	if health == 0:
		print("game over")
		Global.game_over = true
	
	

func _ready() -> void:
	spawn_enemy()

func _process(delta: float) -> void:
	pass
	

func spawn_enemy():
	var new_enemy = preload("res://Scenes/enemy.tscn").instantiate()
	%spawnpathfollow.progress_ratio = randf()
	new_enemy.global_position = %spawnpathfollow.global_position
	add_child(new_enemy)


func _on_enemy_spawn_timer_timeout() -> void:
	spawn_enemy()
