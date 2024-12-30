extends Node2D
class_name Level

@export var max_health = 5
@export var health = 5
@onready var level_complete = false
@export var Wave: WaveManager
@export var enemy_counter: Area2D

signal base_hurt

func _on_hurt_zone_body_entered(body: Node2D) -> void:
	health -= 1
	emit_signal("base_hurt")
	print (health)
	body.queue_free()
	if health == 0:
		%end_menu.visible = true
		get_tree().paused = true


func _ready() -> void:
	%main_menu.visible = true
	get_tree().paused = true
	%anim.play("main_menu_start")
	

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("pause") == true:
		if %pause_menu.visible == false:
			pause()

func _process(delta: float) -> void:
	pass
	
func level_start():
	var current_wave = Wave.current_wave + 1
	var format_string: String = "Wave {str}"
	var current_wave_string: String = format_string.format({"str":current_wave})
	%wave_intro_numb.text = current_wave_string
	Game_Data.current_wave = current_wave
	%UpgradeSelector.visible = false
	get_tree().paused = false
	if current_wave >= Game_Data.highest_wave:
		Game_Data.highest_wave = current_wave
	%SaverLoader.save_game()
	
	%anim.play("saved_game_confirmation")
	await %anim.animation_finished
	Wave.new_wave()
	Wave.wave_change()
	
func level_change():
	print("method called")
	get_tree().paused = true
	var enemy_in_game = enemy_counter.get_overlapping_bodies()
	for bodies in enemy_in_game:
		bodies.queue_free()
	%UpgradeSelector.visible = true
	
	

func pause():
	%pause_menu.visible = true
	get_tree().paused = true

func unpause():
	%pause_menu.visible = false
	get_tree().paused = false

func _on_despawn_left_body_entered(body: Node2D) -> void:
	body.queue_free()


func _on_despawn_right_body_entered(body: Node2D) -> void:
	body.queue_free()





func _on_wave_manager_level_complete() -> void:
	level_change()
	level_complete = true
	


func _on_upgrade_selector_visibility_changed() -> void:
	if %UpgradeSelector.visible == false:
		level_start()


func _on_player_player_death() -> void:
	%end_menu.visible = true
	get_tree().paused = true
