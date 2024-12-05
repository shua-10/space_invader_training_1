extends Control


@export var player:Player
@export var bullet_damage_upgrade: Resource
@export var missle_damage_upgrade: Resource
@export var burst_override_upgrade: Resource

func _ready() -> void:
	visible = !visible
	
func _on_bullet_damage_button_pressed() -> void:
	player.bullet_upgrades.append(bullet_damage_upgrade)
	visible = false


func _on_missle_damage_button_pressed() -> void:
	player.bullet_upgrades.append(missle_damage_upgrade)
	visible = false

func _on_burst_override_button_pressed() -> void:
	player.bullet_upgrades.append(burst_override_upgrade)
	visible = false
