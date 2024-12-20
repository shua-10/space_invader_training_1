extends Node2D
class_name HealthComponent

@export var max_health = 3
var health: float
signal death
signal health_change

func _ready() -> void:
	health = max_health
	

func take_damage(attack: AttackComponent):
	health -= attack.attack_damage
	health_change.emit()
	
	if health <= 0:
		emit_signal("death")
		
		
