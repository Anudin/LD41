extends Node

export var extend = Vector2(0,0)

onready var Parent = get_parent()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if Parent.position.x - extend.x < 0:
		Parent.position.x = extend.x
	elif Parent.position.x + extend.x > get_viewport().size.x:
		Parent.position.x = get_viewport().size.x - extend.x
	elif Parent.position.y - extend.y < 0:
		Parent.position.y = extend.y
	elif Parent.position.y + extend.y > get_viewport().size.y:
		Parent.position.y = get_viewport().size.y - extend.y
	else:
		return
	
	Parent._on_screen_collision()
