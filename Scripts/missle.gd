extends Area2D


@export var SPEED = 500
@export var LAUNCH_SPEED = 20
@export var attack_damage = 3
@export var enemy: Enemy


func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	var launch_dir = Vector2.LEFT.rotated(rotation)
	
	
	var enemy_in_range = get_overlapping_bodies()
	if enemy_in_range.size() > 0:
		var target_enemy = enemy_in_range.front()
		look_at(target_enemy.global_position)
		%AnimatedSprite2D.play("detecting")
		position += SPEED * delta * direction
		%AnimatedSprite2D.play("attack")
	else:
		%AnimatedSprite2D.play("idle")
		position += LAUNCH_SPEED * delta * launch_dir

func _process(delta: float) -> void:
	pass



func _on_hit_box_component_area_entered(area: Area2D) -> void:
	var AOE_in_range = self.get_overlapping_bodies()
	var explosion = preload("res://Scenes/missle_explosion.tscn").instantiate()
	if area is HitBoxComponent:
	
		var hitbox: HitBoxComponent = area
		var attack = AttackComponent.new()
		attack.attack_damage = attack_damage
		# use for allows us to break apart arrays and apply functions individually. with set up 
		# unfortuanley have to count out in which spot hitboxcomponent is.... may be a better way
		for areas in AOE_in_range:
			var area_children = areas.get_children()
			for hitbox_find in area_children:
				if hitbox_find is HitBoxComponent:
					hitbox_find.take_damage(attack)
		self.queue_free()
		explosion.global_position = self.global_position
		explosion.emitting = true
		get_parent().add_child(explosion)
