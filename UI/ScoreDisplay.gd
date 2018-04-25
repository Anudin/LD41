tool

extends "res://UI/Menu.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func execute():
	print("display")
	if selected == 0:
		hide()

func hide():
	toggle_visibility()
	get_tree().paused = false