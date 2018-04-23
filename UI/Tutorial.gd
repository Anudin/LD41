extends Label

onready var camera = $"/root/Main/Player/Camera2D"

var played = false

func _ready():
	pass
	#camera.offset = Vector2(camera.get_parent().position.x,camera.get_parent().position.y)

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass

func _input(event):
	if event.is_action_pressed("strict_accept"):
		#camera.offset = Vector2(0,0)
		played = true
		hide()
		get_tree().paused = false
