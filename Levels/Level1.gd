extends "res://Levels/Level.gd"

var skip_tutorial = false

func save():
	return {"skip_tutorial": $TutorialText.played}

func before():
	if skip_tutorial:
		$TutorialText.hide()
		return
	
	get_tree().paused = true

func win_condition():
	for enemy in get_tree().get_nodes_in_group("enemies"):
		if enemy.alive:
			return false
		
	for spawn in get_tree().get_nodes_in_group("enemy_spawn"):
		if spawn.get_remaining_spawns() != 0:
			return false
	
	return true

func _ready():
	pass

#func _process(delta):
#	print(win_condition())
