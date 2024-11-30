extends ProgressBar
class_name HealthBar

@export var health_component: HealthComponent

func _ready() -> void:
	max_value = health_component.max_health
	

func _process(delta: float) -> void:
	value = health_component.health
	
	
