extends "res://Levels/Level.gd"

var skip_tutorial = false

func save():
	return {"skip_tutorial": $TutorialLayer/TutorialText.played}

func before():
	if skip_tutorial:
		$TutorialLayer/TutorialText.hide()
		return
	
	get_tree().paused = true

func win_condition():
	return get_tree().get_nodes_in_group("enemy_spawn").size() == 0

func _ready():
	pass

#func _process(delta):
#	print(win_condition())
