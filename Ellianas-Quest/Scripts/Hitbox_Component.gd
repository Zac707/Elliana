extends Node2D

var attack_damage := 3.0



func _on_body_entered(body):
	print(attack_damage)
	if body.has_method("damage"):
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		body.damage(attack)
	
