extends Node


@export var player: Player


func save_game():
	var saved_game:SavedGame = SavedGame.new()
	saved_game.highest_wave = Game_Data.highest_wave
	saved_game.high_score = Game_Data.high_score
	
	ResourceSaver.save(saved_game,"user://savegame.tres")

func load_game():
	var saved_game:SavedGame = load("user://savegame.tres") as SavedGame
	
	if saved_game != null:
		
		Game_Data.highest_wave = saved_game.highest_wave
		Game_Data.high_score = saved_game.high_score
	else:
		return
	
