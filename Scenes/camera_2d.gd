extends Camera2D
class_name LevelCamera

@export var randomStrength: float = 10.0
@export var shakeFade: float = 5.0

@onready var background = %ParallaxBackground

var shake_strength: float = 0.0

var background_offset: Vector2

func _process(delta: float) -> void:
	
	
	
	if shake_strength > 0:
			shake_strength = lerpf(shake_strength,0,shakeFade * delta)
			offset = randomOffset()
			

func camera_shake():
	var timer = get_tree().create_timer(0.3)
	enabled = true
	shake_strength = randomStrength
	background.set_scroll_base_offset(background.offset_before_shake + background.base_offset_before_shake)

	await timer.timeout
	enabled = false

	
func randomOffset() -> Vector2:
	return Vector2(Global.rng.randf_range(-shake_strength,shake_strength),
	Global.rng.randf_range(-shake_strength,shake_strength))

func _on_player_player_health_change() -> void:
	background.offset_save()
	camera_shake()
