tool

extends "res://UI/Menu.gd"

signal play_audio

func _ready():
	connect("play_audio", $"/root/Main", "toggle_audio")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func execute():
	if selected == 0:
		hide()
	elif selected == 1:
		emit_signal("play_audio")

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		hide()

func hide():
	toggle_visibility()
	get_tree().paused = false