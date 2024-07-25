extends Node2D

var damage = 10
var shoot_delay = 1
var reload_time = 5
var magazine_size = 3
var current_ammo = 3
var can_shoot = true
var reloading = false
func _ready():
	$DelayTimer.wait_time = shoot_delay
	$ReloadTimer.wait_time = reload_time
	#privet

# Called every frame. 'delta' is the elapsed time since the previous frame.
	


func shoot():
	if current_ammo <= 0:
		if !reloading:
			reload()
		return
	if can_shoot:
		can_shoot = false
		current_ammo -= 1
		$RayCast2D.force_raycast_update()
		if $RayCast2D.is_colliding():
			var collider = $RayCast2D.get_collider()
			if collider.is_in_group("Enemy"):
				print("Enemy")
				collider.take_damage(damage)
			elif collider.is_in_group("Objects"):
				print("Wall")
		else:
			print("miss")
		$DelayTimer.start()
			

func _on_delay_timer_timeout():
	can_shoot = true
	
func reload():
	reloading = true
	can_shoot = false
	$ReloadTimer.start()
	await $ReloadTimer.timeout
	current_ammo = magazine_size
	can_shoot = true
	reloading = false
