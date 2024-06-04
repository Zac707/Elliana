extends CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var overlapping_object1 = get_overlapping_areas()[0]
	var overlapping_object2 = get_overlapping_bodies()[1]
