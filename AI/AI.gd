extends Sprite

# TODO: I might run into problems because I'm scaling a colliders parent
# TODO: Maybe fix collisions between multiple AIs

# TODO: slow down / relax depending on distance
# TODO: dodge walls
# TODO (maybe): relaxed state + random walk.

onready var Player = $"/root/Main/Player"

var last_position = Vector2(0,0)
var speed = 60

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):	
	var angle_to_player = rad2deg(get_angle_to(Player.position))
	var attraction_modifier = -1
	
	if position.distance_to(Player.position) > 300:
		attraction_modifier = 1
	
	position += (Player.position - position).normalized() * speed * delta * attraction_modifier
	
#	if angle_to_player >= -45 and angle_to_player <= 45:
#		position.x -= speed * delta * attraction_modifier
#	if angle_to_player >= 135 or angle_to_player <= -135:
#		position.x += speed * delta * attraction_modifier
#	if angle_to_player >= 45 and angle_to_player <= 135:
#		position.y -= speed * delta * attraction_modifier
#	if angle_to_player <= -45 and angle_to_player >= -135:
#		position.y += speed * delta * attraction_modifier

func _on_screen_collision():
	pass

func _on_area_entered(area):
	pass
