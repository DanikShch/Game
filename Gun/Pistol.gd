extends "res://Gun/gun.gd"
var ammo = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_active():
	$"..".damage = 10
	$"..".shoot_delay = 0.5
	$"..".reload_time = 3
	$"..".magazine_size = 15
	$"..".current_ammo = 15
	$"..".range = 500
