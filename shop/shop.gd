extends Node2D


var player
var guns_type = ["SMG","Assault","Shotgun","Sniper","Grenade"]
var costs = [1000,1000,1000,1000,1000]

func _ready():
	pass # Replace with function body.


func set_player(player_obj):
	player = player_obj


func _process(delta):
	pass


func _on_menu_button_pressed():
	buy_gun(0)


func _on_menu_button_2_pressed():
	buy_gun(1)
	
	
func _on_menu_button_3_pressed():
	buy_gun(2)
	
	
func _on_menu_button_4_pressed():
	buy_gun(3)
	
	
func _on_menu_button_5_pressed():
	buy_gun(4)
	
	
func buy_gun(index):
	if player.money >= costs[index]:
		if player.add_new_gun(guns_type[index]):
			player.money = player.money - costs[index]
			print("Money: ", player.money)
			print(player.guns_type)
	
	



