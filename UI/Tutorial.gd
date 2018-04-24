extends Label

onready var camera = $"/root/Main/Player/Camera2D"

var played = false

func _ready():
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _input(event):
	if visible and event.is_action_pressed("strict_accept"):
		played = true
		hide()
		get_tree().paused = false
