extends Node



var game_over = false

func _process(delta: float) -> void:
	restart_game()


func restart_game():
	if game_over == true:
		get_tree().reload_current_scene()
		game_over = false
		
