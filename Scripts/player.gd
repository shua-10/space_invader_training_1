extends CharacterBody2D
class_name Player


@export var SPEED = 600
@export var normal_shoot_rate: float = 0.5
@export var rapid_shoot_rate: float = 0.1
@export var missle_limit: int = 3
var missle_current_count: int
	
@onready var animated_sprite_2d: AnimatedSprite2D = $"CanvasLayer/PanelContainer/Panel/VBoxContainer/HBoxContainer/Q Button/AnimatedSprite2D"
@onready var no_sign: TextureRect = $CanvasLayer/PanelContainer/Panel/VBoxContainer/HBoxContainer2/BlasterBolt/NoSign
@onready var no_sign_missle: TextureRect = $CanvasLayer/PanelContainer/Panel/VBoxContainer/HBoxContainer2/Missle/NoSignMissle
@onready var missle_display_count: Label = $CanvasLayer/PanelContainer/Panel/VBoxContainer/HBoxContainer2/Missle/Missle_display_count
@onready var animated_sprite_2d_2: AnimatedSprite2D = $"CanvasLayer/PanelContainer/Panel/VBoxContainer/HBoxContainer/E Button/AnimatedSprite2D2"
@onready var anim_norm: AnimationPlayer = $anim_norm
@onready var anim_effects: AnimationPlayer = $anim_effects


var rapid_inprogress = false
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

	if Input.is_action_just_pressed("deploy_missle") == true and missle_ready == true:
		shoot_missle()
		missle_ready = false
		%Missle_Cooldown.start()
		no_sign_missle.visible = true
		animated_sprite_2d_2.visible = true
		animated_sprite_2d_2.play("cooldown",2/%Missle_Cooldown.time_left)
		await animated_sprite_2d_2.animation_finished
		animated_sprite_2d_2.visible = false
		no_sign_missle.visible = false
		
		
	var format_str_missle_count:String = "{str}x"
	var str_missle_count:String = format_str_missle_count.format({"str":missle_current_count})
	missle_calc()
	missle_display_count.text = str_missle_count
	if missle_current_count == 0:
		no_sign_missle.visible = true
	elif missle_current_count != 0:
		no_sign_missle.visible = false


	if Input.is_action_just_pressed("rapid_fire") == true and rapid_fire_ready == true:
		%Shoot_Cooldown.wait_time = rapid_shoot_rate
		%Rapid_fire_duration.start()
		no_sign.visible = true
		rapid_fire_ready = false
		

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
func missle_calc():
	missle_current_count = missle_limit - missle_count


func no_damage():
	$HitBoxComponent.set_collision_layer_value(5,false)
	anim_effects.play("invinsible_flash")
	await anim_effects.animation_finished
	$HitBoxComponent.set_collision_layer_value(5,true)

func _on_shoot_cooldown_timeout() -> void:
	shoot_ready = true


func _on_missle_cooldown_timeout() -> void:
	missle_ready = true


func _on_health_component_death() -> void:
	self.queue_free()
	player_death.emit()



func _on_health_component_health_change() -> void:
	anim_effects.play("take_damage")
	no_damage()
	emit_signal("player_health_change")


func _on_rapid_fire_duration_timeout() -> void:
	%Shoot_Cooldown.wait_time = normal_shoot_rate
	%rapid_fire_cooldown.start()
	animated_sprite_2d.visible = true
	animated_sprite_2d.play("cooldown", 2/%rapid_fire_cooldown.time_left)
	%Rapid_fire_duration.stop()
	await animated_sprite_2d.animation_finished
	animated_sprite_2d.visible = false
	no_sign.visible = false
	
	


func _on_rapid_fire_cooldown_timeout() -> void:
	rapid_fire_ready = true
	%rapid_fire_cooldown.stop()
