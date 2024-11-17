extends CharacterBody2D

@export var SPEED = 600
var shoot_ready = true

func _physics_process(delta: float) -> void:
	
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	
	velocity = direction * SPEED
	
	move_and_slide()

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot") == true and shoot_ready == true:
		shoot()
		%Shoot_Cooldown.start()
		shoot_ready = false
		
		

func shoot():
	const NEW_BULLET = preload("res://Scenes/bullet.tscn")
	var bullet_left = NEW_BULLET.instantiate()
	var bullet_right = NEW_BULLET.instantiate()
	
	bullet_left.global_position = %ShootPoint_Left.global_position
	#bullet_left.global_rotation = %ShootPoint_Left.global_rotation
	get_parent().add_child(bullet_left)
	
	bullet_right.global_position = %ShootPoint_Right.global_position
	#bullet_right.global_rotation = %ShootPoint_Right.global_rotation
	get_parent().add_child(bullet_right)

func _on_shoot_cooldown_timeout() -> void:
	shoot_ready = true
