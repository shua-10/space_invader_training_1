extends CharacterBody2D

@export var SPEED = 600
var shoot_ready = true
var smooth_mouse_position: Vector2

func _ready() -> void:
	$Ship/AnimatedSprite2D.play("idle")

func _physics_process(delta: float) -> void:
	
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	
	smooth_mouse_position = lerp(smooth_mouse_position, get_global_mouse_position(), 0.3)
	
	look_at(smooth_mouse_position)
	
	velocity = direction * SPEED
	
	move_and_slide()

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot") == true and shoot_ready == true:
		shoot()
		%Shoot_Cooldown.start()
		shoot_ready = false
		$Ship/AnimatedSprite2D.play("shooting")

	
func shoot():
	const NEW_BULLET = preload("res://Scenes/bullet.tscn")
	var bullet_left = NEW_BULLET.instantiate()
	var bullet_right = NEW_BULLET.instantiate()
	
	bullet_left.global_position = %ShootPoint_Left.global_position
	bullet_left.global_rotation = %ShootPoint_Left.global_rotation
	get_parent().add_child(bullet_left)
	
	bullet_right.global_position = %ShootPoint_Right.global_position
	bullet_right.global_rotation = %ShootPoint_Right.global_rotation
	get_parent().add_child(bullet_right)

func _on_shoot_cooldown_timeout() -> void:
	shoot_ready = true
