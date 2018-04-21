extends Node2D

const COMMANDS = ["up", "down", "left", "right", "stop"]
const TEMP_COMMANDS = {"sdf": "jump", "isd": "pick up"}

func _ready():
	randomize()
	
	update_temp_commands_display()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func verify_command(command):
	if COMMANDS.has(command):
		return true
	elif TEMP_COMMANDS.has(command):
		var action = TEMP_COMMANDS[command]
		update_temp_commands(command)
		return action

func update_temp_commands(action_code):
	var action = TEMP_COMMANDS[action_code]
	TEMP_COMMANDS.erase(action_code)
	
	var key = ""
	
	while(key == "" or TEMP_COMMANDS.has(key)):
		for i in range(3):
			key += char(randi()%26 + "a".ord_at(0))
			
	TEMP_COMMANDS[key] = action
	
	update_temp_commands_display()

func update_temp_commands_display():
	var command_display = ""
	
	# TODO: Keep order
	for key in TEMP_COMMANDS.keys():
		command_display += TEMP_COMMANDS[key] + ": " + key + "\n"

	$UI/CommandMapping.text = command_display