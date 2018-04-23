extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	var player = $"/root/Main/Player"
	player.position = position
	player.rotation = 0
	player.direction = Vector2(0,1)
	player.velocity = Vector2(0,0)
	player.get_node("Camera2D").align()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
