extends "res://Gun/gun.gd"

var explosion_radius = 70
# Called when the node enters the scene tree for the first time.
func _ready():
	$ExplodeArea/CollisionShape2D.shape.radius = explosion_radius

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_active():
	$"..".damage = 30
	$"..".shoot_delay = 1
	$"..".reload_time = 3
	$"..".magazine_size = 1
	$"..".current_ammo = 1
	$"..".range = 500

func shoot():
	$"../RayCast2D".force_raycast_update()
	if $"../RayCast2D".is_colliding():
		var collision_point = $"../RayCast2D".get_collision_point()
		$ExplodeArea.global_position = collision_point
		await get_tree().create_timer(0.25).timeout
		for body in $ExplodeArea.get_overlapping_bodies():
			if body.is_in_group("Enemy"):
				body.take_damage($"..".damage)
	else:
		print("Miss!")
