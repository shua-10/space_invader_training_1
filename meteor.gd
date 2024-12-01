extends CharacterBody2D


@export var SPEED = 150
@export var attack_damage = 5
var vector_initial: Vector2 = Vector2(250,250)


func _ready() -> void:
	set_velocity(vector_initial)

func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	



func _on_hit_box_component_area_entered(area: Area2D) -> void:
	if area is HitBoxComponent:
		var hitbox: HitBoxComponent = area
		
		var attack = AttackComponent.new()
		attack.attack_damage = attack_damage
		hitbox.take_damage(attack)



func _on_health_component_death() -> void:
	self.queue_free()
