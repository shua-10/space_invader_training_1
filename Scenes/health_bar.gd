extends ProgressBar
class_name PlayerHealthBar

@onready var player: Player = %player

func _ready() -> void:
	max_value = player.max_health
	print(max_value, value)
func _process(delta: float) -> void:
	if value >= max_value * 0.50:
		modulate = ref.green_health_bar
	if value < max_value * 0.50:
		modulate = ref.yellow_health_bar
	if value < max_value * 0.30:
		modulate = ref.red_health_bar


func health_check():
	var player_children = player.get_children()
	for child in player_children:
		if child is HealthComponent:
			value = child.health


func _on_player_player_health_change() -> void:
	var player_children = player.get_children()
	for child in player_children:
		if child is HealthComponent:
			value = child.health


func _on_upgrade_selector_health_restored() -> void:
	health_check()
