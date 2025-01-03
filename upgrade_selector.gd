extends Control
class_name UpgradeController

@export var player:Player
@export var bullet_damage_upgrade: Resource

@export var level: Level
@onready var bullet_damage_button: Button = $PanelContainer/Panel/VBoxContainer/HBoxContainer/bullet_damage_button

signal health_restored


func _ready() -> void:
	pass
	
func _on_bullet_damage_button_pressed() -> void:
	if player.player_attack_damage <= 1.0:
		player.bullet_upgrades.append(bullet_damage_upgrade)
		visible = false
		Sfx.play_button_press()
	else:
		bullet_damage_button.disabled = true


func _on_health_restore_button_pressed() -> void:
	var player_children = player.get_children()
	for child in player_children:
		if child is HealthComponent:
			child.health = child.max_health
	
	level.health = level.max_health
	Sfx.play_button_press()
	visible = false
	
	emit_signal("health_restored")


func _on_reload_missle_button_pressed() -> void:
	player.missle_count = 0
	Sfx.play_button_press()
	visible = false
