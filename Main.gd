extends Node2D

# TODO: Fill queue from start / finish / clear it

# TODO: shooting text gets longer with time / level / difficulty settings
# TODO: REALLY satisfying shooting mechanic.

const COMMANDS = ["up", "down", "left", "right", "stop"]
const TEMP_COMMANDS = {"sdf": "shoot"}

func _ready():
	randomize()
	
	_on_queue_updated([])
	update_temp_commands_display()

func _process(delta):
	if get_tree().get_nodes_in_group("enemies").size() == 0:
		print("You're a winner!")
		call_deferred("restart_game")

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
	if health > 0:
		$UI/PlayerHealth.text = str(health)
	else:
		call_deferred("restart_game")
		
func restart_game():
	var root = $"/root"
	root.remove_child($"/root/Main")
	root.add_child(load("res://Main.tscn").instance())
	queue_free()
