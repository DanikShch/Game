extends "res://Gun/gun.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_active():
	$"..".damage = 10
	$"..".shoot_delay = 0.2
	$"..".reload_time = 5
	$"..".magazine_size = 20
	$"..".current_ammo = 20
	$"..".range = 500
