extends ParallaxBackground

@export var SPEED: int = 100


var offset_before_shake: Vector2
var base_offset_before_shake: Vector2

func _process(delta: float) -> void:
	scroll_offset.y += SPEED * delta

func offset_save():
	offset_before_shake = scroll_offset
	base_offset_before_shake = scroll_base_offset
