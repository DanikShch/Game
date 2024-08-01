extends "res://Gun/gun.gd"
var ammo = 100
var spread_angle = 15.0
var raycasts: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_rays()

func setup_rays():
	raycasts += [$RayCast2D1,$RayCast2D2,$RayCast2D3,$RayCast2D4,$"../RayCast2D"]
	$RayCast2D1.rotation_degrees = spread_angle
	$RayCast2D2.rotation_degrees = 2 * spread_angle
	$RayCast2D3.rotation_degrees = - spread_angle
	$RayCast2D4.rotation_degrees = -2 * spread_angle

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func set_active():
	$"..".damage = 5
	$"..".shoot_delay = 1
	$"..".reload_time = 5
	$"..".magazine_size = 10
	$"..".range = 300
	for ray in raycasts:
		ray.target_position.x = $"..".range
		ray.force_raycast_update()
		
func shoot():
	for ray in raycasts:
		ray.force_raycast_update()
		if ray.is_colliding():
			var collider = ray.get_collider()
			if collider.is_in_group("Enemy"):
				print("Enemy")
				collider.take_damage($"..".damage)
			elif collider.is_in_group("Objects"):
				print("Wall")
		else:
			print("miss")
