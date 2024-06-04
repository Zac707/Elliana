extends Node2D

var attack_damage := 3.0
var velocity: Vector2
var duration = 3



func _on_area_entered(area):
	if area.has_method("damage_player"):
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		area.damage_player(attack)
		queue_free()

func _physics_process(delta):
	position += velocity *delta
	duration -= delta
	if duration <= 0:
		queue_free()
