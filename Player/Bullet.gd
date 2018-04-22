extends Sprite

var AI = preload("res://AI/AI.gd")

var direction = Vector2(0,0)
var speed = 800

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

func _on_area_shape_entered(area_id, area, area_shape, self_shape):
	if (area.get_parent().name == "AI" and area_shape == area.get_parent().collider_id) or \
	area.is_in_group("walls"):
		$Area2D/CollisionShape2D.disabled = true
		queue_free()
