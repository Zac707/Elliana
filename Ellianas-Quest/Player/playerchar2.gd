extends CharacterBody2D 
@export var move_speed : float = 80
@export var starting_position : Vector2 = Vector2 (0,1)
@export var last_direction : String
@onready var plat = $Plat

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")
@onready var grounded_sprites = $standing_sprites
@onready var jump_sprites = $jumping_sprites
@onready var attack_sprites = $Damage_Component_Player/Sword
@onready var attack_hitbox = $Damage_Component_Player/CollisionShape2D
var usable = false
var input_direction
var inputs_enabled = true

func _ready():
	
	jump_sprites.visible = false
	attack_sprites.visible = false
	update_animation_parameters (starting_position)

func _physics_process(_delta):
	
	input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	if inputs_enabled == true:
		update_animation_parameters (input_direction)
	
	if get_meta("on_standing_plat") == true:
		Global.invulnerable = true
	if get_meta("on_plat") == true:
		velocity = input_direction.normalized() * move_speed + Global.plat_velocity
		Global.invulnerable = true
	else:
		velocity = input_direction.normalized() * move_speed
		
	if (Input.is_action_just_pressed("jump") and usable == false):
		set_collision_mask_value(3, true)
		set_collision_mask_value(1, false)
		grounded_sprites.visible = false
		jump_sprites.visible = true
		Global.invulnerable = true
		usable = true
	if (Input.is_action_just_pressed("Attack") and usable == false):
		attack_sprites.visible = true
		grounded_sprites.visible = false
		usable = true
	
	if inputs_enabled == true:
		pick_new_state()
	
	move_and_slide() 
	
func update_animation_parameters (move_input : Vector2):
	
	if (move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/Idle/blend_position", move_input)
		animation_tree.set("parameters/Jump/blend_position", move_input)
		animation_tree.set("parameters/Sword/blend_position", move_input)

func pick_new_state():
	
	if (attack_sprites.visible == true and usable == true):
		state_machine.travel("Sword")
		inputs_enabled = false
	elif (grounded_sprites.visible == false and usable == true):
		inputs_enabled = false
		state_machine.travel("Jump")
	elif (velocity != Vector2.ZERO and input_direction != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")



func reset():
	
	if get_meta("on_plat")  == false and get_meta("on_standing_plat") == false:
		Global.invulnerable = false
	set_collision_mask_value(1, true)
	set_collision_mask_value(3, false)
	grounded_sprites.visible = true
	jump_sprites.visible = false
	attack_sprites.visible = false
	inputs_enabled = true
	$Timer.start()
	attack_hitbox.position.x = 0
	attack_hitbox.position.y = 0
	attack_hitbox.disabled = true

	
func _on_timer_timeout():
	usable = false

func enable_movement():
	inputs_enabled = true

func attack_right():
	attack_hitbox.disabled = false
	attack_hitbox.position.x = 15
	attack_hitbox.position.y = 0
func attack_left():
	attack_hitbox.disabled = false
	attack_hitbox.position.x = -15
	attack_hitbox.position.y = 0
func attack_up():
	attack_hitbox.disabled = false
	attack_hitbox.position.x = 0
	attack_hitbox.position.y = -15
func attack_down():
	attack_hitbox.disabled = false
	attack_hitbox.position.x = 0
	attack_hitbox.position.y = 15
func attack_up_right():
	attack_hitbox.disabled = false
	attack_hitbox.position.x = -8
	attack_hitbox.position.y = -8
func attack_up_left():
	attack_hitbox.disabled = false
	attack_hitbox.position.x = 8
	attack_hitbox.position.y = -8
func attack_down_right():
	attack_hitbox.disabled = false
	attack_hitbox.position.x = 8
	attack_hitbox.position.y = 8
func attack_down_left():
	attack_hitbox.disabled = false
	attack_hitbox.position.x = -8
	attack_hitbox.position.y = 8
