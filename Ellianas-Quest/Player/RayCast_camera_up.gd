extends RayCast2D
@onready var camera_2d = $"../Camera2D"
@onready var playerchar = $".."
var player_pos
var get_pos = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_colliding():
		if get_pos == true:
			get_player_position()
		camera_2d.limit_top = player_pos.y - 130
	
	else:
		get_pos = true
		camera_2d.limit_top = -1000000000
		


func get_player_position():
	player_pos = playerchar.global_position
	get_pos = false
