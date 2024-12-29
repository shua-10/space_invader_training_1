extends CharacterBody2D
class_name Player


@export var SPEED = 600
@export var normal_shoot_rate: float = 0.5
@export var rapid_shoot_rate: float = 0.1
@export var missle_limit: int = 3

var shoot_ready = true
var smooth_mouse_position: Vector2
var missle_ready = true
var rapid_fire_ready = true
var bullet_upgrades:Array[BulletUpgrades] = []
var missle_count: int = 0
var health: int
var max_health: int
signal player_death
signal player_health_change


func _ready() -> void:
	$AnimatedSprite2D.play("idle")
	health = $HealthComponent.health
	max_health = $HealthComponent.max_health


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
		$AnimatedSprite2D.play("shooting")

	if Input.is_action_pressed("deploy_missle") == true and missle_ready == true:
		shoot_missle()
		%Missle_Cooldown.start()
		missle_ready = false

	if Input.is_action_pressed("rapid_fire") == true and rapid_fire_ready == true:
		%Shoot_Cooldown.wait_time = rapid_shoot_rate
		%Rapid_fire_duration.start()


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
	
	$Shooting_Sound.play()
	
	


func shoot_missle():
	if missle_count >= missle_limit:
		return
	else:
		const NEW_MISSLE = preload("res://Scenes/missle.tscn")
		var missle = NEW_MISSLE.instantiate()
		
		missle.global_position = %MisslePoint.global_position
		missle.global_rotation = %MisslePoint.global_rotation
		
		get_parent().add_child(missle)
		missle_count += 1
		if missle_count >= missle_limit:
			return

func _on_shoot_cooldown_timeout() -> void:
	shoot_ready = true


func _on_missle_cooldown_timeout() -> void:
	missle_ready = true


func _on_health_component_death() -> void:
	self.queue_free()
	player_death.emit()



func _on_health_component_health_change() -> void:
	$AnimationPlayer.play("take_damage")
	emit_signal("player_health_change")


func _on_rapid_fire_duration_timeout() -> void:
	%Shoot_Cooldown.wait_time = normal_shoot_rate
	%rapid_fire_cooldown.start()
	%Rapid_fire_duration.stop()
	rapid_fire_ready = false


func _on_rapid_fire_cooldown_timeout() -> void:
	rapid_fire_ready = true
	%rapid_fire_cooldown.stop()
