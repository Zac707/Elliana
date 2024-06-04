extends Node2D

var attack_damage := 3.0


func _on_area_entered(area):
	if area.has_method("damage"):
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		area.damage(attack)
