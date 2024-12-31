extends Control

@onready var reg_killed_numb: Label = $PanelContainer/Panel/VBoxContainer3/HBoxContainer/VBoxContainer2/reg_killed_numb
@onready var fast_killed_numb: Label = $PanelContainer/Panel/VBoxContainer3/HBoxContainer/VBoxContainer2/fast_killed_numb
@onready var carrier_killed_numb: Label = $PanelContainer/Panel/VBoxContainer3/HBoxContainer/VBoxContainer2/carrier_killed_numb
@onready var high_score_numb: Label = $"PanelContainer/Panel/VBoxContainer3/HBoxContainer/VBoxContainer2/high score_numb"
@onready var highest_wave_numb: Label = $"PanelContainer/Panel/VBoxContainer3/HBoxContainer/VBoxContainer2/highest wave_numb"



func _process(delta: float) -> void:
	
	reg_killed_numb.text = str(Game_Data.regular_enemy_killed)
	fast_killed_numb.text = str(Game_Data.fast_enemy_killed)
	carrier_killed_numb.text = str(Game_Data.carrier_enemy_killed)
	high_score_numb.text = str(Game_Data.high_score)
	highest_wave_numb.text = str(Game_Data.highest_wave)
	

func _on_back_button_pressed() -> void:
	visible = false
	Sfx.play_button_press()
