extends Node


signal health_changed (health: float)
signal object_death (health: float)

@export var max_health = 3
@onready var health = max_health

@export var hurtbox = Node2D

func _ready() -> void:
	pass

func death():
	if health <= 0:
		self.queue_free()
		

func take_damage(attack: Attack):
	health -= attack.attack_damage
	print(health)
