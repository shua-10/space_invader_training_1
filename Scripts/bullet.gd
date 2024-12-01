extends Area2D

@export var SPEED = 1800
@export var attack_damage = 1

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	




func _on_hit_box_component_area_entered(area: Area2D) -> void:
	if area is HitBoxComponent:
		var hitbox: HitBoxComponent = area
		
		var attack = AttackComponent.new()
		attack.attack_damage = attack_damage
		hitbox.take_damage(attack)
		self.queue_free()