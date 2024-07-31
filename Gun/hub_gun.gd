extends CharacterBody2D

var damage = 10
var shoot_delay = 0.5
var reload_time = 5
var magazine_size = 120
var current_ammo = 120
var range_value = 5000
var enable = true
var ready_to_shoot = true
var body = []
var text_edit


func _ready():
	check_player_collision()



func _physics_process(delta):
	if enable && ready_to_shoot:
		body = $Attack_area.get_overlapping_bodies()
		for enemy in body:
			if enemy.is_in_group("Enemy"):
				print(enemy)
				var pos = enemy.get_global_position()
				var angle = rad_to_deg(atan2(pos.y - global_position.y, pos.x - global_position.x))
				$".".rotation_degrees = angle
				move_and_slide()
				shoot(enemy)
				
	if check_player_collision():
		text_edit.set_visible(true)
		if Input.is_action_just_pressed("Enable"):
			enable = !enable
	else:
		text_edit.set_visible(false)
		
			
				
				
				
func shoot(enemy):
	if current_ammo > 0:
		enemy.take_damage(damage)
		current_ammo = current_ammo - 1
		ready_to_shoot = false
		await get_tree().create_timer(shoot_delay).timeout
		ready_to_shoot = true
	else:
		ready_to_shoot = false
		await get_tree().create_timer(reload_time).timeout
		current_ammo = 120
		ready_to_shoot = true
		
		
func set_text(text):
	text_edit = text
	
	
func check_player_collision():
		var result = false
		var body = $Control_area.get_overlapping_bodies()
		for player in body:
			if player.is_in_group("Player"):
				result = true		
		return result
		
			
		
	
	
		
	
