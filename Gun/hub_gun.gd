extends CharacterBody2D

var damage = 10
var shoot_delay = 0.5
var reload_time = 5
var magazine_size = 120
var current_ammo = 3
var range_value = 5000
var enabele = false
var body = []





func _physics_process(delta):
	body = $Area2D.get_overlapping_bodies()
	for enemy in body:
		if enemy.is_in_group("Enemy"):
			print("enemy")
	
		
	
