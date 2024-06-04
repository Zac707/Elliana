extends Area2D

@onready var player = $/root/Gamelevel/Playerchar
@export var health_component : Node2D

# Called when the node enters the scene tree for the first time.
func damage_player(attack : Attack):
	if Global.invulnerable == false:
		if health_component:
			health_component.damage_player(attack)
