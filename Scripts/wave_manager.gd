extends Node

class_name WaveManager
signal enemy_picked
signal fast_enemy_picked
signal carrier_picked
signal level_complete

@export var wave_data: WaveParameters
@export var spawn_path: SpawnPath

@export var wave_array:Array[WaveParameters]
var current_wave: float


func _ready() -> void:
	current_wave = 0
	wave_data = wave_array.front()
	
func _process(delta: float) -> void:
	if wave_data.wave_death_limit <= spawn_path.total_death_count:
		spawn_path.total_death_count = 0
		spawn_path.current_death_enemy_count = 0
		spawn_path.current_death_fast_enemy_count = 0
		spawn_path.current_death_carrier_count = 0
		spawn_path.current_enemy_count = 0
		spawn_path.current_fast_enemy_count = 0
		spawn_path.current_carrier_count =0
		emit_signal("level_complete")
		print("level_complete")
func new_wave():
	enemy_picker()
	
func enemy_picker():
	
	var enemy_picker_rng: float = Global.rng.randf_range(0, 1)
	print(spawn_path.total_count,"  ",wave_data.wave_death_limit)
	print(enemy_picker_rng)
	if wave_data.carrier_prob_min < enemy_picker_rng and wave_data.carrier_prob_max > enemy_picker_rng:
		emit_signal("carrier_picked")
	elif wave_data.fast_enemy_prob_min < enemy_picker_rng and wave_data.fast_enemy_prob_max > enemy_picker_rng:
		emit_signal("fast_enemy_picked")
		print("spawned")
	elif wave_data.regular_enemy_prob_min < enemy_picker_rng and wave_data.regular_enemy_prob_max > enemy_picker_rng:
		emit_signal("enemy_picked")
		print("spawned")

func wave_change():
	if wave_array.size()>1:
		wave_array.remove_at(0)
		wave_data = wave_array.front()
	else:
		return
