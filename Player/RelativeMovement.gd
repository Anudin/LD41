extends Node

onready var Player = get_parent()

func _ready():
	$"/root/Main/UI/TextInput".connect("text_command", self, "_on_text_command")

func _on_text_command(command):
	if command == "left":
		Player.rotate(deg2rad(-90))
		Player.direction = Player.direction.rotated(deg2rad(-90))
		Player.velocity = Player.direction * Player.SPEED_MODIFIER
	elif command == "right":
		Player.rotate(deg2rad(90))
		Player.direction = Player.direction.rotated(deg2rad(90))
		Player.velocity = Player.direction * Player.SPEED_MODIFIER
	elif command == "go":
		Player.velocity += Player.direction * Player.SPEED_MODIFIER
	elif command == "stop":
		Player.velocity = Vector2(0,0)
