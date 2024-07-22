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
		$Gun.shoot()
		



