extends ProgressBar
class_name PlayerHealthBar

@onready var player: Player = $"../../../../player"

func _ready() -> void:
	max_value = player.max_health




func _on_player_player_health_change() -> void:
	var player_children = player.get_children()
	
	for child in player_children:
		if child is HealthComponent:
			value = child.health
