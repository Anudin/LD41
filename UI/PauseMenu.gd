tool

extends "res://UI/Menu.gd"

signal play_audio

#func set_child_visibility():
#	#.set_child_visibility()
#
#	for child in get_children():
#		print(child)
#		child.visible = visible

func _ready():
	connect("play_audio", $"/root/Main", "toggle_audio")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func execute():		
	if selected == 0:
		toggle_visibility()
		get_tree().paused = false
	elif selected == 1:
		emit_signal("play_audio")
