extends Node
class_name HurtBox

@export var health_component = Node2D



func _on_body_entered(body: Node2D) -> void:
	var attack = Attack.new() #inserts new instance of script (change variables)
	health_component.take_damage(attack)
