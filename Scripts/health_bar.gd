extends ProgressBar
class_name HealthBar

@export var health_component: HealthComponent

func _ready() -> void:
	max_value = health_component.max_health
	

func _process(delta: float) -> void:
	value = health_component.health
	
	if value >= max_value * 0.50:
		modulate = ref.green_health_bar
	if value < max_value * 0.50:
		modulate = ref.yellow_health_bar
	if value < max_value * 0.30:
		modulate = ref.red_health_bar
