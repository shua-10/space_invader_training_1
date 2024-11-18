extends CharacterBody2D

@export var SPEED = 150
var enemy_alive = true
@export var health = 3
@export var RANGE = 100


func _physics_process(delta: float) -> void:
	
	
	position.y += SPEED * 1 * delta
	
	var travelled_distance = SPEED * delta
	
	if travelled_distance > RANGE:
		queue_free()
	
	



func _process(delta: float) -> void:
	pass
	
	 
func take_damage():
	health -= 1
	%HealthBar.value = health
	if health == 0:
		queue_free()
