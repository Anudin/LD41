extends "res://Levels/Level.gd"

func win_condition():
	return get_tree().get_nodes_in_group("enemy_spawn").size() == 0

func _ready():
	._ready()

#func _process(delta):
#	print(win_condition())
