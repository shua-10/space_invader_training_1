extends Control
class_name UpgradeController

@export var player:Player
@export var bullet_damage_upgrade: Resource

@export var level: Level

signal health_restored


func _ready() -> void:
	pass
	
func _on_bullet_damage_button_pressed() -> void:
	player.bullet_upgrades.append(bullet_damage_upgrade)
	visible = false


func _on_health_restore_button_pressed() -> void:
	var player_children = player.get_children()
	for child in player_children:
		if child is HealthComponent:
			child.health = child.max_health
	
	level.health = level.max_health
	visible = false
	
	emit_signal("health_restored")


func _on_reload_missle_button_pressed() -> void:
	player.missle_count = 0
	visible = false
