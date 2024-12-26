extends CanvasLayer

@export var wave_manager: WaveManager

func _process(delta: float) -> void:
	var format_str_highscore: String = "High Score {str}"
	var str_highscore: String = format_str_highscore.format({"str":Game_Data.high_score})

	var format_str_highwave: String = "Highest Wave {str}"
	var str_highwave: String = format_str_highwave.format({"str":Game_Data.highest_wave})
	
	var format_str_currentscore: String = "Score {str}"
	var str_currentscore: String = format_str_currentscore.format({"str":Game_Data.current_score})

	var format_str_currentwave: String = "Wave {str}"
	var str_currentwave: String = format_str_currentwave.format({"str":Game_Data.current_wave})
	
	var format_str_wave_enemies: String = "{str1} of {str2}"
	var str_wave_enemies: String = format_str_wave_enemies.format({"str1": Game_Data.total_death_count, "str2": wave_manager.wave_data.wave_death_limit})
	%high_score.text = str_highscore
	%highest_wave.text = str_highwave
	
	
	%current_score.text = str_currentscore
	%current_wave.text = str_currentwave
	
	%wave_enemies.text = str_wave_enemies
	Game_Data.total_death_calc()
