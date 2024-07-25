extends CharacterBody2D

const SPEED = 300.0
var guns_type = ["Pistol","SMG","Assault","Shotgun","Sniper","Grenade"]
var guns_num = 0
var health = 20.0
var max_health = 20.0


func get_health():
	return health
	
func get_max_health():
	return max_health


func _physics_process(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		velocity.x += SPEED
		$Sprite2D.flip_h = false
	if Input.is_action_pressed("left"):
		velocity.x -= SPEED
		$Sprite2D.flip_h = true
	if Input.is_action_pressed("up"):
		velocity.y -= SPEED
		$Sprite2D.flip_v = false
	if Input.is_action_pressed("down"):
		velocity.y += SPEED
		$Sprite2D.flip_v = true
	move_and_slide()
	$Camera2D.position = Vector2(0,0)
	var mouse_pos = get_global_mouse_position()
	var angle = rad_to_deg(atan2(mouse_pos.y - global_position.y, mouse_pos.x - global_position.x))
	$".".rotation_degrees = angle
	
	if Input.is_action_pressed("shoot"):
		$Gun.shoot()
	if Input.is_action_just_released("weapon_change_up"):
		guns_num = guns_num + 1
		if guns_num > guns_type.size()-1:
			guns_num = 0
		
		$Gun.select_gun(guns_type[guns_num])
		print(guns_type[guns_num])
	if Input.is_action_just_released("weapon_change_down"):
		guns_num = guns_num - 1
		if guns_num < 0:
			guns_num = guns_type.size() -1
		
		$Gun.select_gun(guns_type[guns_num])
		print(guns_type[guns_num])
		
		
		
func take_damage(damage):
	health = health - damage
	if health <= 0:
		print("dead")
		
	print("player health: "+ str(health))
	

