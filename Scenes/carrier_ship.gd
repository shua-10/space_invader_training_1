extends CharacterBody2D
class_name CarrierShip

signal carrier_died

@export var SPEED = 50
var enemy_alive = true
@export var health = 3
@export var RANGE = 100
@export var attack_damage = 1
var enemy = self
var shot_cooldown_active:bool = false
var shot_count:int = 0

func _physics_process(delta: float) -> void:
	
	
	position.y += SPEED * 1 * delta
	rotation += 0.02
	
	var travelled_distance = SPEED * delta
	
	if travelled_distance > RANGE:
		queue_free()
	
	move_and_collide(velocity)



func _process(delta: float) -> void:
	pass
	

func shoot_bullet():
	const NEW_BULLET = preload("res://carrier_bullet.tscn")
	var bullet_left = NEW_BULLET.instantiate()
	var bullet_right = NEW_BULLET.instantiate()
	var bullet_up = NEW_BULLET.instantiate()
	var bullet_down = NEW_BULLET.instantiate()
	print(%Left_Point.global_rotation)
	print(%Right_Point.global_rotation)
	
	bullet_left.global_rotation = %Left_Point.global_rotation
	bullet_left.global_position = %Left_Point.global_position
	bullet_left.direction = Vector2.from_angle(3.14 + %Left_Point.global_rotation)
	get_parent().add_child(bullet_left)
	
	bullet_right.global_position = %Right_Point.global_position
	bullet_right.global_rotation = %Right_Point.global_rotation
	bullet_right.direction = Vector2.from_angle(%Right_Point.global_rotation)
	get_parent().add_child(bullet_right)

	bullet_down.global_rotation = %Down_Point.global_rotation
	bullet_down.global_position = %Down_Point.global_position
	bullet_down.direction = Vector2.from_angle(1.571 + %Down_Point.global_rotation)
	get_parent().add_child(bullet_down)

	bullet_up.global_rotation = %Up_Point.global_rotation
	bullet_up.global_position = %Up_Point.global_position
	bullet_up.direction = Vector2.from_angle(-1.571 + %Up_Point.global_rotation)
	get_parent().add_child(bullet_up)


	shot_count += 1
	print(shot_count)
	if shot_count == 3:
		shot_cooldown_active = true
		$Shoot_cooldown.start()
		
#func shoot_laser():
	#const NEW_LASER = preload("res://Scenes/laser_enemy.tscn")
	#var laser = NEW_LASER.instantiate()
	
	#laser.global_position = %LaserPoint.global_position
	
	
	##add_child(laser)
	

func _on_hit_box_component_area_entered(area: Area2D) -> void:
	if area is HitBoxComponent:
		var hitbox: HitBoxComponent = area
		var attack = AttackComponent.new()
		attack.attack_damage = attack_damage
		hitbox.take_damage(attack)
		


func _on_health_component_death() -> void:
	var explosion = preload("res://Scenes/enemy_explosion.tscn").instantiate()
	explosion.global_position = enemy.global_position
	explosion.emitting = true
	get_parent().add_child(explosion)
	enemy.queue_free()
	
	carrier_died.emit()
	
	
#func _on_laser_timer_timeout() -> void:
	#shoot_laser()


func _on_shoot_rate_timeout() -> void:
	if shot_cooldown_active == false:
		shoot_bullet()



func _on_shoot_cooldown_timeout() -> void:
	if shot_cooldown_active == true:
		shot_count = 0
	shot_cooldown_active = false
	


func _on_health_component_health_change() -> void:
	$AnimationPlayer.play("take_damage")


func _on_shield_radius_body_entered(body: Node2D) -> void:
	if body is Meteor:
		$AnimationPlayer.play("shield_damage")
