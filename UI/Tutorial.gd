extends Label

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass

func _input(event):
	if event.is_action("ui_accept"):
		hide()
		get_tree().paused = false