extends "res://Levels/Level.gd"

func before():
	get_tree().paused = true
	
	get_tree().paused = false

func win_condition():
	return get_tree().get_nodes_in_group("enemy_spawn").size() == 0

func _ready():
	pass

#func _process(delta):
#	print(win_condition())
