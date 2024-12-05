extends CharacterBody2D
class_name Player
@export var SPEED = 600
var shoot_ready = true
var smooth_mouse_position: Vector2
var missle_ready = true
var bullet_upgrades:Array[BulletUpgrades] = []

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
		shoot_bullet()
		%Shoot_Cooldown.start()
		shoot_ready = false
		$Ship/AnimatedSprite2D.play("shooting")

	if Input.is_action_pressed("deploy_missle") == true and missle_ready == true:
		shoot_missle()
		%Missle_Cooldown.start()
		missle_ready = false

func shoot_bullet():
	const NEW_BULLET = preload("res://Scenes/bullet.tscn")
	var bullet_left = NEW_BULLET.instantiate()
	var bullet_right = NEW_BULLET.instantiate()
	
	for upgrades in bullet_upgrades:
		upgrades.apply_upgrades(bullet_left)

	bullet_left.global_position = %ShootPoint_Left.global_position
	bullet_left.global_rotation = %ShootPoint_Left.global_rotation
	get_parent().add_child(bullet_left)
	
	for upgrades in bullet_upgrades:
		upgrades.apply_upgrades(bullet_right)
	bullet_right.global_position = %ShootPoint_Right.global_position
	bullet_right.global_rotation = %ShootPoint_Right.global_rotation
	get_parent().add_child(bullet_right)
	
	
	
	


func shoot_missle():
	const NEW_MISSLE = preload("res://Scenes/missle.tscn")
	var missle = NEW_MISSLE.instantiate()
	
	missle.global_position = %MisslePoint.global_position
	missle.global_rotation = %MisslePoint.global_rotation
	
	get_parent().add_child(missle)
	
func _on_shoot_cooldown_timeout() -> void:
	shoot_ready = true


func _on_missle_cooldown_timeout() -> void:
	missle_ready = true


func _on_health_component_death() -> void:
	self.queue_free()
