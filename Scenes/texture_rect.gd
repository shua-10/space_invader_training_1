extends ParallaxBackground

@export var SPEED: int = 100

func _process(delta: float) -> void:
	scroll_offset.y += SPEED * delta
