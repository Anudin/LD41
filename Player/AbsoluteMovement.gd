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
		
		# Direct change of direction
		if Player.velocity + Player.direction * Player.SPEED_MODIFIER == Vector2(0,0):
			Player.velocity = Vector2(0,0)
		
		Player.velocity += Player.direction * Player.SPEED_MODIFIER
