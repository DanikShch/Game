extends CharacterBody2D

var damage = 10
var shoot_delay = 0.5
var reload_time = 5
var magazine_size = 120
var current_ammo = 120
var range_value = 5000
var enable = false
var ready_to_shoot = true
var body = []





func _physics_process(delta):
	if enable && ready_to_shoot:
		body = $Area2D.get_overlapping_bodies()
		for enemy in body:
			if enemy.is_in_group("Enemy"):
				print(enemy)
				shoot(enemy)
				
				
				
func shoot(enemy):
	if current_ammo > 0:
		enemy.take_damage(damage)
		current_ammo = current_ammo - 1
		ready_to_shoot = false
		await get_tree().create_timer(shoot_delay).timeout
		ready_to_shoot = true
	else:
		ready_to_shoot = false
		await get_tree().create_timer(reload_time).timeout
		current_ammo = 120
		ready_to_shoot = true
	
		
	
		
	
