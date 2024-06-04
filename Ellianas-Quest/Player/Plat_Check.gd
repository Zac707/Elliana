extends Area2D

@onready var playerchar = $".."
@export var health_component : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_body_entered(body):
	if body.is_in_group("Platforms"):
		playerchar.set_meta("on_plat", true) 
		
	


func _on_body_exited(body):
	if body.is_in_group("Platforms"):
		playerchar.set_meta("on_plat", false)
		if playerchar.get_collision_mask_value(1) == true:
			Global.invulnerable = false


func _on_area_entered(area):
	if area.is_in_group("Platforms"):
		playerchar.set_meta("on_standing_plat", true) 
		


func _on_area_exited(area):
	if area.is_in_group("Platforms"):
		playerchar.set_meta("on_standing_plat", false)
		if playerchar.get_collision_mask_value(1) == true:
			Global.invulnerable = false
		

func damage_player(attack : Attack):
	if Global.invulnerable == false:
		if health_component:
			health_component.damage_player(attack)
