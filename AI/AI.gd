extends Sprite

# TODO: I might run into problems because I'm scaling a colliders parent
# TODO: Maybe fix collisions between multiple AIs

# TODO: slow down / relax depending on distance
# TODO: dodge walls

onready var Player = $"/root/Main/Player"

var last_position = Vector2(0,0)
var speed = 30

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	last_position = Vector2(position.x,position.y)
	#print("last position ",last_position)
	
	var angle_to_player = rad2deg(get_angle_to(Player.position))
	
	if angle_to_player >= -45 and angle_to_player <= 45:
		position.x -= speed * delta
	elif angle_to_player >= 135 or angle_to_player <= -135:
		position.x += speed * delta
	elif angle_to_player >= 45 and angle_to_player <= 135:
		position.y -= speed * delta
	elif angle_to_player <= -45 and angle_to_player >= -135:
		position.y += speed * delta
	
	#print("position ",position)

func _on_screen_collision():
	pass

func _on_area_entered(area):
	pass#print(position,last_position)
	#position = Vector2(last_position.x,last_position.y)
