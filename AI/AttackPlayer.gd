extends Node

onready var Parent = get_parent()
onready var Player = $"/root/Main/Player"

var last_position = Vector2(0,0)
var speed = 30

var cleanup = false

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if cleanup:
		return
	
	var angle_to_player = rad2deg(Parent.get_angle_to(Player.position))
	
	Parent.position += (Player.position - Parent.position).normalized() * speed * delta

func _on_animation_finished():
	Parent.queue_free()

func _on_area_entered(area):
	if area == Player.get_node("Area2D"):
		cleanup = true
		Parent.play("explode")
		Parent.get_node("Area2D/CollisionShape2D").disabled = true
		Player._on_hit()
