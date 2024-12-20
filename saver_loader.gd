extends Node


@export var player: Player


func save_game():
	var saved_game:SavedGame = SavedGame.new()
	saved_game.bullet_upgrades = player.bullet_upgrades
	
	ResourceSaver.save(saved_game,"user://savegame.tres")

func load_game():
	var saved_game:SavedGame = load("user://savegame.tres") as SavedGame
	
	player.bullet_upgrades = saved_game.bullet_upgrades
