extends Area2D

@export var SPEED = 1800
@export var attack_damage = 1
var in_damage_zone = false
var attack_ready = true

func _ready() -> void:
	$AnimatedSprite2D.play("laser_shoot")
func _physics_process(delta: float) -> void:
	if in_damage_zone == true and attack_ready == true:
		var attack = AttackComponent.new()
		var attack_rate:float = 1
		attack.attack_damage = attack_damage + attack_rate * delta
		
		
		attack_ready = false
		%damage_time.start()



func _on_hit_box_component_area_entered(area: Area2D) -> void:
	in_damage_zone = true
		

func _on_damage_time_timeout() -> void:
	attack_ready = true

func _on_hit_box_component_area_exited(area: Area2D) -> void:
	in_damage_zone = false
