extends Area2D


@export var SPEED = 500
@export var LAUNCH_SPEED = 20
@export var attack_damage = 1
@export var enemy: Enemy


func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	var launch_dir = Vector2.DOWN.rotated(rotation)
	
	var enemy_in_range = get_overlapping_bodies()
	if enemy_in_range.size() > 0:
		var target_enemy = enemy_in_range.front()
		look_at(target_enemy.global_position)
		print("overlapped")
		position += SPEED * delta * direction
	else:
		position += LAUNCH_SPEED * delta * launch_dir


func _on_hit_box_component_area_entered(area: Area2D) -> void:
	if area is HitBoxComponent:
		var hitbox: HitBoxComponent = area
		
		var attack = AttackComponent.new()
		attack.attack_damage = attack_damage
		hitbox.take_damage(attack)
		self.queue_free()
