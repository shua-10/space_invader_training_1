extends Area2D
class_name HitBoxComponent

@export var health_component: HealthComponent

func take_damage(attack: AttackComponent):
	if health_component:
		health_component.take_damage(attack)
		
