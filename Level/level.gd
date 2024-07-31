extends Node2D

var max_mobs_count = 20
var max_mob_on_the_scene = 3
var mobs_count = 0
@export var enemy_scene: PackedScene = preload("res://Enemy/enemy.tscn")
var spawn_positions = []
var spawn_delay = 5
var ready_to_spawn = true


func _ready():
	spawn_positions.append($SpawnPoint.global_position)
	spawn_positions.append($SpawnPoint2.global_position)
	spawn_positions.append($SpawnPoint3.global_position)
	spawn_positions.append($SpawnPoint4.global_position)
	#print_debug_values()
	$hub/hub_gun.set_text($CanvasLayer/TextEdit)


func _process(delta):
	if ready_to_spawn:
		spawn()


func spawn():
	if mobs_count < max_mob_on_the_scene && max_mobs_count > 0:
		ready_to_spawn = false
		var mob = enemy_scene.instantiate()
		
		# Выбираем случайную позицию спавна из массива
		var spawn_position = spawn_positions[randi() % spawn_positions.size()]
		
		# Устанавливаем позицию моба
		mob.global_position = spawn_position      
		# Добавляем моба в сцену
		add_child(mob)
		
		# Увеличиваем счетчик мобов
		mobs_count += 1	
		await get_tree().create_timer(spawn_delay).timeout
		ready_to_spawn = true
		

func mobs_dead():
	max_mobs_count = max_mobs_count - 1
	mobs_count = mobs_count - 1
	print("mob dead")
	
	
func print_debug_values():
	while true:
		await get_tree().create_timer(3.0).timeout
		print("max_mobs_count: ", max_mobs_count)
		print("max_mob_on_the_scene: ", max_mob_on_the_scene)
		print("mobs_count: ", mobs_count)
		print("spawn_positions: ", spawn_positions)
		print("spawn_delay: ", spawn_delay)
		print("ready_to_spawn: ", ready_to_spawn)
