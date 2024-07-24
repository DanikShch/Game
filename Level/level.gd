extends Node2D


var isDie = false
@onready var child_node = $Enemy
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!isDie):
		var player_transform = $Player.get_global_transform()
		var enemy_position = Vector2(player_transform.origin.x, player_transform.origin.y)
		var result = $Enemy.set_pos(enemy_position)
		if result == -1:
			isDie = true
			remove_child(child_node)
			child_node.queue_free()
			
			
		

