extends "res://Levels/Level.gd"

var initial = true
var arrived = false 

var responses = [
	"That might be a tree... I think.",
	"At least they can't see your artistic\nskill in this resolution.",
	"You could've at least included audio commentary.",
	"Wait a second. I don't look like a walker."
] setget , get_responses

func before():
	get_tree().paused = true

func win_condition():
	return arrived

func _ready():
	pass

func get_responses():
	if initial:
		initial = false
		return ["An 8-bit walking sim... Are you serious?"]
	else:
		return responses

#func _process(delta):
#	print(win_condition())
