extends Control



@onready var player = $"../../Player"
var max_size


func _ready():
	max_size = $Front.size.x

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var procent = player.get_health()/player.get_max_health()
	$Front.size.x = max_size * procent
