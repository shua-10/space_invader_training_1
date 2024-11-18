extends Node


signal health_changed (health: float)

@export var max_health = 3
@onready var health = max_health

@export var hurtbox = Node2D
