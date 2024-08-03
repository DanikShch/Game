extends CanvasLayer

@onready var player_hp_bar = $"Control/Player HP bar"
@onready var mob_hp_bar = $"Control/Mob HP bar"
@onready var player = $"../Player"
var texture_dict = {}

@onready var selected = $Pistol_rect


# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.connect("mob_health",Callable(self,"_set_mob_health"))
	Signals.connect("no_target",Callable(self,"_on_no_target"))
	Signals.connect("ammo",Callable(self,"_change_ammo"))
	Signals.connect("reload",Callable(self,"_on_reload"))
	update_max_player_hp(player.max_health)
	update_player_hp(player.health)
	print(player.max_health)
	print(player.health)
	mob_hp_bar.visible = false
	texture_dict = {
	"Pistol" : $Pistol_rect,
	"SMG" : $SMG_rect,
	"Assault" : $Ak_rect,
	"Shotgun" : $Shotgun_rect,
	"Sniper" : $Rifle_rect,
	"Grenade" : $Pistol_rect
}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update_player_hp(value):
	player_hp_bar.value = value
	
func update_max_player_hp(value):
	player_hp_bar.max_value = value
	
func _set_mob_health(current_hp: int, max_hp: int):
	mob_hp_bar.value = current_hp
	mob_hp_bar.max_value = max_hp
	mob_hp_bar.visible = true
	
func _on_no_target():
	mob_hp_bar.visible = false
	
func _change_ammo(ammo: int, current_ammo: int,current_gun: String):
	$Control/PanelContainer/HBoxContainer/Ammo.text = str(ammo)
	$Control/PanelContainer/HBoxContainer/CurrentAmmo.text = str(current_ammo)
	
	
func _on_reload(time):
	$Control/PanelContainer/HBoxContainer/Reload.show()
	await get_tree().create_timer(time).timeout
	$Control/PanelContainer/HBoxContainer/Reload.hide()
