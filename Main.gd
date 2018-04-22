extends Node2D

# Quirks: Can't rename folder (in use?)

# Must be done today! (at least)
# -> Add state machine to level system (transitions etc.)

# TODO: Tutorial
# TODO: Safestate
# TODO: Sound [Warn sound, shot, explosion, typing, moving?]
# TODO: Main menu - New Game, Continue, Controls maybe difficulty setting
# TODO: Particles - trails!, blood, smoke etc.

var COMMANDS = []
const TEMP_COMMANDS = {"sdf": "shoot"}

func _ready():
	randomize()
	
	_on_queue_updated([])
	update_temp_commands(TEMP_COMMANDS.keys()[0])

func _process(delta):
	pass

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
		for i in range($Level.LAUNCH_CODE_LENGTH):
			key += char(randi()%26 + "a".ord_at(0))
			
	TEMP_COMMANDS[key] = action
	
	update_temp_commands_display()

func update_temp_commands_display():
	var command_display = ""
	
	for key in TEMP_COMMANDS.keys():
		command_display += TEMP_COMMANDS[key] + ": " + key + "\n"

	$UI/CommandMapping.text = command_display

func _on_health_changed(health):	
	if health > 0:
		$UI/PlayerHealth.value = health
	else:
		call_deferred("restart_game")
		
func restart_game():
	var root = $"/root"
	root.remove_child($"/root/Main")
	root.add_child(load("res://Main.tscn").instance())
	queue_free()
