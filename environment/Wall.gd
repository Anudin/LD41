tool

extends Area2D

export var width = 32 setget set_width
export var height = 32 setget set_height

func _ready():
	var collider = RectangleShape2D.new()
	collider.extents = Vector2(width / 2, height / 2)
	
	var owner_id = create_shape_owner(self)
	shape_owner_add_shape(owner_id, collider)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func set_width(value):
	width = value
	
	if has_node("Sprite"):
		$Sprite.scale.x = value / 16
	
func set_height(value):
	height = value
	
	if has_node("Sprite"):
		$Sprite.scale.y = value / 16