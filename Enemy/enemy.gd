extends CharacterBody2D


var SPEED = 300.0
var accel = 7
var health = 20

@onready var nav: NavigationAgent2D = $NavigationAgent2D
var target_pos = Vector2()

func set_pos(pos):
	target_pos = pos
	
	
func take_damage(damage):
	health-=damage
	if health <= 0:
		return -1
	print(health)
	SPEED = 150.0
	await get_tree().create_timer(1.5).timeout
	SPEED = 300
	return 1
	
	
	

func _physics_process(delta):
	
	var direction = Vector3();
	
	nav.target_position = target_pos
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized();
	
	velocity = velocity.lerp(direction*SPEED,accel*delta)
	
	var angle = rad_to_deg(atan2(target_pos.y - global_position.y, target_pos.x - global_position.x))
	$".".rotation_degrees = angle
	
	move_and_slide()




