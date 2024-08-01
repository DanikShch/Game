extends Node2D

var damage = 10
var shoot_delay
var reload_time = 5
var magazine_size = 3
var current_ammo = 3
var range = 5000

var guns: Dictionary = {}
var current_gun

var can_shoot = true
var reloading = false
func _ready():
	guns["Pistol"] = $Pistol
	guns["SMG"] = $SubmachineGun
	guns["Assault"] = $AssaultRifle
	guns["Shotgun"] = $Shotgun
	guns["Sniper"] = $SniperRifle
	guns["Grenade"] = $GrenadeLauncher
	current_gun = "Pistol"
	select_gun(current_gun)
# Called every frame. 'delta' is the elapsed time since the previous frame.
	
func _process(delta):
	if $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider()
		if collider != null && collider.is_in_group("Enemy"):
			var health = collider.health
			var max_health = collider.max_health
			Signals.emit_signal("mob_health", health, max_health)
			return
	Signals.emit_signal("no_target")
	

func shoot():
	Signals.emit_signal("ammo", guns[current_gun].ammo, current_ammo)
	if guns[current_gun].ammo == 0:
		return
	if current_ammo <= 0:
		if !reloading:
			reload()
		return
	if can_shoot:
		can_shoot = false
		current_ammo -= 1
		guns[current_gun].ammo -= 1
		$DelayTimer.start()
		if current_gun == "Shotgun":
			$Shotgun.shoot()
			return
		if current_gun == "Grenade":
			$GrenadeLauncher.shoot()
			return
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
		
			

func _on_delay_timer_timeout():
	can_shoot = true
	
func reload():
	reloading = true
	can_shoot = false
	$ReloadTimer.start()
	await $ReloadTimer.timeout
	if magazine_size > guns[current_gun].ammo:
		current_ammo = guns[current_gun].ammo
	else:
		current_ammo = magazine_size
	can_shoot = true
	reloading = false

func select_gun(gun_name: String):
	if guns.has(gun_name):
		guns[current_gun].hide()
		current_gun = gun_name
		guns[current_gun].show()
		guns[current_gun].set_active()
		$DelayTimer.wait_time = shoot_delay
		$ReloadTimer.wait_time = reload_time
		$RayCast2D.target_position.x = range
	else:
		print("Wrong gun name")
