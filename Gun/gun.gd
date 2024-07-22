extends Node2D

var damage
var shoot_delay = 1
var reload_time = 3
var magazine_size = 30
var current_ammo = 30
var can_shoot = true
func _ready():
	$DelayTimer.wait_time = shoot_delay
	$ReloadTimer.wait_time = reload_time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$RayCast2D.look_at(get_global_mouse_position())
	pass
	


func shoot():
	if current_ammo <= 0:
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
			elif collider.is_in_group("Objects"):
				print("Wall")
		else:
			print("miss")
		$DelayTimer.start()
			

func _on_delay_timer_timeout():
	can_shoot = true
	
func reload():
	can_shoot = false
	$ReloadTimer.timeout
	current_ammo = magazine_size
	can_shoot = true
