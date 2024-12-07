extends Path2D


@export var vector_dir: Vector2
@export var spawn_timer: Timer
@export var timer_min: float
@export var timer_max: float
signal meteor_spawned

func _ready() -> void:
	spawn_timer.wait_time = randf_range(timer_min,timer_max)
	spawn_timer.start()
func spawn_meteor():
	var new_meteor = preload("res://Scenes/meteor.tscn").instantiate()
	
	
	%Meteor_Path.progress_ratio = randf()
	new_meteor.position = %Meteor_Path.global_position
	new_meteor.vector_initial = vector_dir
	add_child(new_meteor)
	meteor_spawned.emit()
	


func _on_right_meteor_timer_timeout() -> void:
	spawn_meteor()
