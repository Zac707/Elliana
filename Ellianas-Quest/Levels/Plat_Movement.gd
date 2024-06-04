extends Path2D
@onready var animation_player = $AnimationPlayer
@export var speed = 1.0
@onready var path = $PathFollow2D
@onready var player = $/root/Gamelevel/Playerchar
var loop = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _process(_delta):
	animation_player.play("move")

