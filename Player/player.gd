extends CharacterBody2D


const SPEED = 300.0

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
	if Input.is_action_pressed("down"):
		velocity.y += SPEED
		$Sprite2D.flip_v = true
	move_and_slide()
	
	if Input.is_action_pressed("shoot"):
		shoot()
		
	$RayCast2D.look_at(get_global_mouse_position())


func shoot():
	$RayCast2D.force_raycast_update()
	if $RayCast2D.is_colliding():
		var collider = $RayCast2D.get_collider()
		if collider.is_in_group("Enemy"):
			print("Enemy")
		elif collider.is_in_group("Objects"):
			print("Wall")
	else:
		print("miss")
