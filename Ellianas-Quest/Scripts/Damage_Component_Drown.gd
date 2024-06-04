extends Area2D

var attack_damage := 1.0
var velocity: Vector2
var duration = 3
@onready var Platcheck: Area2D = $/root/Gamelevel/Playerchar/Plat
@onready var player = $/root/Gamelevel/Playerchar


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var overlap = get_overlapping_areas()
	for area in overlap:
		if area == Platcheck and Global.invulnerable == false:
			drowning_damage(area)


func drowning_damage(area):
	if area.has_method("damage_player"):
		var attack = Attack.new()
		attack.attack_damage = 3
		area.damage_player(attack)
