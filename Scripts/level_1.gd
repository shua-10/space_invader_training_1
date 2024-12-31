extends Node2D
class_name Level

@export var max_health = 5
@export var health = 5
@onready var level_complete = false
@export var Wave: WaveManager
@export var enemy_counter: Area2D
@onready var player: Player = %player
@onready var camera_2d: LevelCamera = $Camera2D


signal base_hurt

func _on_hurt_zone_body_entered(body: Node2D) -> void:
	health -= 1
	emit_signal("base_hurt")
	print (health)
	body.queue_free()
	if health == 0:
		game_over()

func game_over():
	var explosion = preload("res://Scenes/enemy_explosion.tscn")
	var new_explosion = explosion.instantiate()
	var tween = get_tree().create_tween()
	
	new_explosion.global_position = player.global_position
	new_explosion.emitting = true
	player.set_physics_process(false)
	player.set_process(false)
	Engine.time_scale = 0.7
	camera_2d.enabled = true
	camera_2d.global_position = player.global_position
	tween.tween_property(camera_2d,"zoom",Vector2(2,2),1.0)
	await tween.finished
	add_child(new_explosion)
	Sfx.play_explosion()
	player.queue_free()
	var timer = get_tree().create_timer(1)
	await timer.timeout
	%end_menu.visible = true
	get_tree().paused = true
	
func _ready() -> void:
	%main_menu.visible = true
	get_tree().paused = true
	%anim.play("main_menu_start")
	player.connect("player_death", game_over)

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
	game_over()
