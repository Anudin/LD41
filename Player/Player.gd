extends Sprite

var direction = Vector2(0,0)
var speed = 60

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	position += direction * speed * delta

func _on_text_command(command):
	if command == "up":
		direction = Vector2(0,-1)
	elif command == "down":
		direction = Vector2(0,1)
	elif command == "left":
		direction = Vector2(-1,0)
	elif command == "right":
		direction = Vector2(1,0)
	elif command == "stop":
		direction = Vector2(0,0)
