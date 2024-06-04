extends PathFollow2D
var previous_pos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	Global.plat_velocity = (global_position - previous_pos) / delta
	previous_pos = global_position
