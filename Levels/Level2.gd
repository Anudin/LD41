extends "res://Levels/Level.gd"

var skip_tutorial = false

var arrived = false

func save():
	return {"skip_tutorial": $TutorialText.played}

func before():
	if skip_tutorial:
		$TutorialText.hide()
		return
	
	get_tree().paused = true

func win_condition():
	return arrived

func _ready():
	pass

#func _process(delta):
#	print(win_condition())
