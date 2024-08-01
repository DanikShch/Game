extends "res://Gun/gun.gd"

var ammo = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_active():
	$"..".damage = 250
	$"..".shoot_delay = 1
	$"..".reload_time = 5
	$"..".magazine_size = 10
	$"..".current_ammo = 10
	$"..".range = 1000
