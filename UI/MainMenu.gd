extends "res://UI/Menu.gd"

signal play_audio

var Main = preload("res://Main.tscn")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func execute():	
	var continue_game = false
	var main = Main.instance()
	
	if selected == 0 or selected == 1:
		if selected == 0:
			continue_game = true
		
		var root = $"/root"
		root.remove_child($"/root/Menu")
		main.setup(continue_game)
		root.add_child(main)
		queue_free()
	elif selected == 2:
		print("audio toggled")
		emit_signal("play_audio", false)
			