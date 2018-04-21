extends Node2D

# TODO: shooting text gets longer with time / level / difficulty settings
# TODO: queue up to 3 actions?
# TODO: REALLY satisfying shooting mechanic.

# TODO: Fill queue from start / finish / clear it

const COMMANDS = ["up", "down", "left", "right", "stop"]
const TEMP_COMMANDS = {"sdf": "shoot"}

func _ready():
	randomize()
	
	_on_queue_updated([])
	update_temp_commands_display()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func verify_command(command):
	if COMMANDS.has(command):
		return command
	elif TEMP_COMMANDS.has(command):
		var action = TEMP_COMMANDS[command]
		update_temp_commands(command)
		return action

func _on_queue_updated(queue):
	if queue.size() == 0:
		$UI/CommandQueue.text = "..."
	else:
		$UI/CommandQueue.text = ""
		
		for command in queue:
			$UI/CommandQueue.text += command + "\n"

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

func _on_health_changed(health):
	$UI/PlayerHealth.text = str(health)
