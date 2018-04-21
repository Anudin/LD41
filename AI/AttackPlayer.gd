extends Node

onready var Parent = get_parent()
onready var Player = $"/root/Main/Player"

var last_position = Vector2(0,0)
var speed = 30

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	var angle_to_player = rad2deg(Parent.get_angle_to(Player.position))
	
	Parent.position += (Player.position - Parent.position).normalized() * speed * delta
