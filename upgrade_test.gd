extends Area2D

@export var upgrade:Resource 

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.bullet_upgrades.append(upgrade)
		self.queue_free()
