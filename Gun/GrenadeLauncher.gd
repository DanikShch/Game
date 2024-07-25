extends "res://Gun/gun.gd"

var explosion_radius
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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

func _shoot():
	$"../RayCast2D".force_raycast_update()
	if $"../RayCast2D".is_colliding():
		var collision_point = $"../RayCast2D".get_collision_point()
		_explode(collision_point)
	else:
		print("Miss!")

func _explode(position: Vector2):
	print("Explosion at: ", position)
	# Создаем область взрыва
	var explosion_area = Area2D.new()
	var explosion_shape = CircleShape2D.new()
	explosion_shape.radius = explosion_radius
	var collision_shape = CollisionShape2D.new()
	collision_shape.shape = explosion_shape
	explosion_area.add_child(collision_shape)
	add_child(explosion_area)
	explosion_area.global_position = position
	
	
	# Наносим урон всем объектам в радиусе
	for body in explosion_area.get_overlapping_bodies():
		if body.is_in_group("Enemy"):
			body.take_damage($"..".damage)
	
	# Удаляем область взрыва после обработки
	explosion_area.queue_free()
