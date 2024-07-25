extends CharacterBody2D


var SPEED = 300.0
var accel = 7
var health = 500

@onready var nav: NavigationAgent2D = $NavigationAgent2D
@onready var player = $"../Player"

func _ready():
	set_physics_process(false)
	call_deferred("navigation_setup")
	
	#для исправления NavigationServer map query failed because it was made before first map synchronization.
func navigation_setup():
	await get_tree().physics_frame
	set_physics_process(true)
	
func take_damage(damage):
	health-=damage
	print(health)
	if health <= 0:
		queue_free()
		return
	SPEED = 150.0
	await get_tree().create_timer(1.5).timeout
	SPEED = 300
	
	
	
	
	

func _physics_process(delta):
	var target_pos = player.position
	nav.target_position = target_pos
	
	var direction = (nav.get_next_path_position() - global_position).normalized()
	velocity = velocity.lerp(direction*SPEED,accel*delta)
	
	var angle = rad_to_deg(atan2(target_pos.y - global_position.y, target_pos.x - global_position.x))
	$".".rotation_degrees = angle
	
	move_and_slide()




