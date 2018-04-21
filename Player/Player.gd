extends Sprite

var Bullet = preload("res://Player/Bullet.tscn")

var direction = Vector2(0,0)
var speed = 60

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	position += direction * speed * delta

# Why am I only receiving one shoot?
func _on_text_command(command):
	movement(command)
	
	if command == "shoot":
		var bullet = Bullet.instance()
		bullet.setup(direction)
		bullet.position = position
		$"/root/Main".add_child(bullet)

func movement(command):
	if command == "up":
		direction.x = 0
		
		if direction.y < 0:
			direction.y += -1
		else:
			direction.y = -1
	elif command == "down":
		direction.x = 0
		
		if direction.y > 0:
			direction.y += 1
		else:
			direction.y = 1
	elif command == "left":
		direction.y = 0
		
		if direction.x < 0:
			direction.x += -1
		else:
			direction.x = -1
	elif command == "right":
		direction.y = 0
		
		if direction.x > 0:
			direction.x += 1
		else:
			direction.x = 1
	elif command == "stop":
		direction = Vector2(0,0)

func _on_screen_collision():
	direction = Vector2(0,0)