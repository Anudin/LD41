extends Node

onready var Player = get_parent()

const COMMANDS = ["up", "down", "left", "right", "stop"]

func _ready():
	$"/root/Main".COMMANDS = COMMANDS
	$"/root/Main/UI/TextInput".connect("text_command", self, "_on_text_command")

func _on_text_command(command):	
	if not command in COMMANDS:
		return
		
	if command == "stop":
		Player.velocity = Vector2(0,0)
	else:
		var rotation = Player.rotation
		
		match command:
			"up":
				Player.rotation = deg2rad(-180)
				Player.direction = Vector2(0,-1)
				Player.velocity.x = 0
			"down":
				Player.rotation = 0
				Player.direction = Vector2(0,1)
				Player.velocity.x = 0
			"left":
				Player.rotation = deg2rad(90)
				Player.direction = Vector2(-1,0)
				Player.velocity.y = 0
			"right":
				Player.rotation = deg2rad(-90)
				Player.direction = Vector2(1,0)	
				Player.velocity.y = 0
		
		var raycast = Player.get_node("RayCast2D")
		raycast.force_raycast_update()
		
		if raycast.is_colliding():
			Player.rotation = rotation
			return
		
		# Direct change of direction
		if sign(Player.velocity.x) != sign(Player.direction.x) or \
		sign(Player.velocity.y) != sign(Player.direction.y) :
			Player.velocity = Vector2(0,0)			
		
		Player.velocity += Player.direction * Player.SPEED_MODIFIER
