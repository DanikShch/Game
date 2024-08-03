extends CharacterBody2D

const SPEED = 300.0
var guns_type = ["Pistol"]
var guns_num = 0
var health = 20.0
var max_health = 20.0
var money = 5000
var texture_dict
var selected

func _ready():
	$".".add_to_group("Player")
	texture_dict = {
	"Pistol" : $Player_text/pistol,
	"SMG" : $Player_text/smg,
	"Assault" : $Player_text/rifle,
	"Shotgun" : $Player_text/shotgun,
	"Sniper" : $Player_text/snipe,
	"Grenade" : $Player_text/pistol
	}
	selected = $Player_text/pistol


func add_new_gun(gun):
	for string in guns_type:
		if string == gun:
			return 0
	guns_type.append(gun)
	return 1
	
func get_health():
	return health
	
func get_max_health():
	return max_health


func _physics_process(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		velocity.x += SPEED
		#$Sprite2D.flip_h = false
	if Input.is_action_pressed("left"):
		velocity.x -= SPEED
		#$Sprite2D.flip_h = true
	if Input.is_action_pressed("up"):
		velocity.y -= SPEED
		#$Sprite2D.flip_v = false
	if Input.is_action_pressed("down"):
		velocity.y += SPEED
		#$Sprite2D.flip_v = true
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
		selected.set_visible(false)
		selected = texture_dict[guns_type[guns_num]]
		selected.set_visible(true)
	if Input.is_action_just_released("weapon_change_down"):
		guns_num = guns_num - 1
		if guns_num < 0:
			guns_num = guns_type.size() -1
		
		$Gun.select_gun(guns_type[guns_num])
		print(guns_type[guns_num])
		selected.set_visible(false)
		selected = texture_dict[guns_type[guns_num]]
		selected.set_visible(true)
		
		
		
func take_damage(damage):
	health = health - damage
	$"../UI".update_player_hp(health)
	if health <= 0:
		print("dead")
		
	print("player health: "+ str(health))
	

