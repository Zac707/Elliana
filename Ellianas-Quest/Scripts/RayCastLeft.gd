extends RayCast2D

@onready var enemy = $".."
@onready var player = $/root/Gamelevel/Playerchar

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_colliding() and get_collider() == player:
		print(enemy)
		enemy.shoot_left()
