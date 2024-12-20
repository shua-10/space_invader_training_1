extends Label

@export var enemy_ref: Node2D

func _ready() -> void:
		text = str(enemy_ref.score)
