extends Sprite

var direction = Vector2(0,0)
var speed = 240

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func setup(direction):
	self.direction = direction

func _process(delta):
	position += direction * speed * delta

func _on_screen_exited():
	queue_free()
