extends CharacterBody2D

var speed = 30
@onready var player = $/root/Gamelevel/Playerchar
@onready var nav_agent = $NavigationAgent2D
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var attack_sprites = $Attack_sprites
@onready var standing_sprites = $enemy
var random = true
var enabled = 4
var shot = 1
var bullet_vel : Vector2
const obj_bullet = preload ("res://damage_component.tscn")
var attack_dir : Vector2
var rng = RandomNumberGenerator.new()

enum AIstate {
	FOLLOW,
	ATTACK,
	RNG,
	FLEE,
	IDLE
}
var state = AIstate.IDLE


func choose_state():
	
	if shot == 2:
		state = AIstate.ATTACK
	elif enabled == 2:
		state = AIstate.FOLLOW
	elif enabled == 1:
		state = AIstate.FLEE
	elif enabled == 3:
		state = AIstate.RNG
	elif enabled == 4:
		state = AIstate.IDLE

func _physics_process(_delta):
	
	var distance = position.distance_to(player.position)
	if distance <= 40:
		enabled = 1
	elif distance >=60 and distance <= 100:
		enabled = 2
	elif distance > 100:
		enabled = 4
	else:
		enabled = 3
	choose_state()

	
	match state:
		AIstate.FOLLOW:
			speed = 30
			standing_sprites.visible = true
			attack_sprites.visible = false
			move()
		AIstate.RNG:
			standing_sprites.visible = true
			attack_sprites.visible = false
			idle()
		AIstate.ATTACK:
			standing_sprites.visible = false
			attack_sprites.visible = true
			speed = 0
			charge()
		AIstate.FLEE:
			standing_sprites.visible = true
			attack_sprites.visible = false
			speed = 30
			run_away()
		AIstate.IDLE:
			standing_sprites.visible = true
			speed = 0



func move ():

	nav_agent.target_position = player.global_position
	var next_path_position = nav_agent.get_next_path_position()
	if next_path_position != Vector2.ZERO:
		var direction = (next_path_position - global_position).normalized()
		direction = constrain_direction(direction)
		velocity = direction * speed
		animation_tree.set("parameters/Idle/blend_position", direction)
		state_machine.travel("Idle")
		move_and_slide()


func run_away ():
	
	nav_agent.target_position = player.global_position
	var next_path_position = nav_agent.get_next_path_position()
	if next_path_position != Vector2.ZERO:
		var direction = (next_path_position - global_position).normalized()* -1
		direction = constrain_direction(direction)
		velocity = direction * speed 
		animation_tree.set("parameters/Idle/blend_position", direction)
		state_machine.travel("Idle")
		move_and_slide()

func idle():
	
	if random == true:
		var direction = Vector2(rng.randf_range(-1, 1), rng.randf_range(-1, 1)).normalized()
		direction = constrain_direction(direction)
		velocity = direction * speed
		animation_tree.set("parameters/Idle/blend_position", direction)
		state_machine.travel("Idle")
		random = false
		$Timer2.start()
	move_and_slide()
	
	
func constrain_direction(dir):
	var angle = dir.angle_to(Vector2.RIGHT)
	var direction_index = int(round(angle / (PI / 4))) % 8
	var directions = [
		Vector2.RIGHT,
		Vector2.RIGHT + Vector2.UP,
		Vector2.UP,
		Vector2.LEFT + Vector2.UP,
		Vector2.LEFT,
		Vector2.LEFT + Vector2.DOWN,
		Vector2.DOWN,
		Vector2.RIGHT + Vector2.DOWN
	]

	return directions[direction_index]
	
func charge():
	nav_agent.target_position = attack_dir
	animation_tree.set("parameters/Attack/blend_position", attack_dir)
	state_machine.travel("Attack")
	
func shoot ():
	var new_bullet = obj_bullet.instantiate()
	add_child(new_bullet)
	new_bullet.velocity = bullet_vel
	$Timer.start()
	shot = 3
	choose_state()


func shoot_left():
	if shot == 1:
		shot = 2
		bullet_vel = Vector2(-120, 0)
		attack_dir = Vector2(-1, 0)
		choose_state()



func shoot_down_left():
	if shot == 1:
		shot = 2
		bullet_vel = Vector2(-60, 60)
		attack_dir = Vector2(-1, 1)
		choose_state()



func shoot_down():
	if shot == 1:
		shot = 2
		bullet_vel = Vector2(0, 120)
		attack_dir = Vector2(0, 1)
		choose_state()



func shoot_down_right():
	if shot == 1:
		shot = 2
		bullet_vel = Vector2(60, 60)
		attack_dir = Vector2(1, 1)
		choose_state()



func shoot_right():
	if shot == 1:
		shot = 2
		bullet_vel = Vector2(120, 0)
		attack_dir = Vector2(1, 0)
		choose_state()



func shoot_up_left():
	if shot == 1:
		shot = 2
		bullet_vel = Vector2(-60, -60)
		attack_dir = Vector2(-1, -1)
		choose_state()



func shoot_up():
	if shot == 1:
		shot = 2
		bullet_vel = Vector2(0, -120)
		attack_dir = Vector2(0, -1)
		choose_state()



func shoot_up_right():
	if shot == 1:
		shot = 2
		bullet_vel = Vector2(60, -60)
		attack_dir = Vector2(1, -1)
		choose_state()



func _on_timer_timeout():
	shot = 1


func _on_timer_2_timeout():
	random = true
