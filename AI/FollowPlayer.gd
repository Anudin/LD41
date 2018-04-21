extends Node

onready var Parent = get_parent()
onready var Player = $"/root/Main/Player"

var last_position = Vector2(0,0)
var speed = 60

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	var angle_to_player = rad2deg(Parent.get_angle_to(Player.position))
	var attraction_modifier = -1
	
	if Parent.position.distance_to(Player.position) > 300:
		attraction_modifier = 1
	
	Parent.position += (Player.position - Parent.position).normalized() * speed * delta * attraction_modifier
	
	#	if angle_to_player >= -45 and angle_to_player <= 45:
	#		position.x -= speed * delta * attraction_modifier
	#	if angle_to_player >= 135 or angle_to_player <= -135:
	#		position.x += speed * delta * attraction_modifier
	#	if angle_to_player >= 45 and angle_to_player <= 135:
	#		position.y -= speed * delta * attraction_modifier
	#	if angle_to_player <= -45 and angle_to_player >= -135:
	#		position.y += speed * delta * attraction_modifier