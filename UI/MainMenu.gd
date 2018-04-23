extends "res://UI/Menu.gd"

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
	var main = Main.instance()
	
	match selected:
		0:
			main.setup(true)
		1:
			main.setup()
	
	var root = $"/root"
	root.remove_child($"/root/Menu")
	root.add_child(main)
	queue_free()