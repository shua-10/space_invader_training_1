extends Area2D

@export var SPEED = 1800


func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	


func _on_body_entered(body: Node2D) -> void:
	self.queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
