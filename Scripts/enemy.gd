extends CharacterBody2D
class_name Enemy

@export var SPEED = 150
var enemy_alive = true
@export var health = 3
@export var RANGE = 100
@export var attack_damage = 1
var enemy = self
signal died
@export var score: int


func _ready() -> void:

	%score_counter.text = str(score)

func _physics_process(delta: float) -> void:
	
	
	position.y += SPEED * 1 * delta
	
	var travelled_distance = SPEED * delta
	
	if travelled_distance > RANGE:
		queue_free()
	
	move_and_collide(velocity)




func _process(delta: float) -> void:
	pass
	
	 


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
	Sfx.explosion_sound.play()
	$AnimatedSprite2D.visible = false
	remove_child($HitBoxComponent)
	remove_child($CollisionShape2D)
	%AnimationPlayer.play("score_count")
	await %AnimationPlayer.animation_finished
	enemy.queue_free()
	died.emit()


func _on_health_component_health_change() -> void:
	if %AnimationPlayer.is_playing():
		return
	else:
		%AnimationPlayer.play("take_damage")


func _on_shield_radius_body_entered(body: Node2D) -> void:
	if body is Meteor:
		$AnimationPlayer2.play("shield")
	if body is Player:
		pass
