extends "res://Levels/Level.gd"

var skip_tutorial = false

var score = 0

func increase_score():
	score += 5
	$ScoreLayer/Score.text = str(score)
	$ScoreAnimation.play("score_effect")

func save():
	return {"skip_tutorial": $TutorialText.played}

func before():
	$"/root/Main/Player/Camera2D".current = true
	
	if skip_tutorial:
		$TutorialText.hide()
		return
	
	get_tree().paused = true

func win_condition():
	return false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
