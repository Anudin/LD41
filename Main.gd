extends Node2D

# Quirks: Can't rename folder (in use?)
# Quirks: Child remove doesn't work...

# TODO: Plan, implement progression
# TODO: Main, Pause (show tutorial), death... menu - New Game, Continue, Controls maybe difficulty setting

# TODO: Sound [Warn sound, shot, explosion, typing, moving?]
# TODO: Particles - trails!, blood, smoke etc.

var COMMANDS = []
const TEMP_COMMANDS = {"whatever": "shoot"}

var level_path

func _ready():
	randomize()
	
	change_level("res://Levels/Intro.tscn")
	#load_game()
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
		for i in range($Level/Level.LAUNCH_CODE_LENGTH):
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

func change_level(path, args = null):
	level_path = path
	var level = load(path).instance()
	
	if args != null:
		for variable in args.keys():
			level.set(variable, args[variable])
	
	if not has_node("Level/Level"):
		$Level.add_child(level)
	else:
		$Level/Level.after()		
		$Level.add_child(level)
	
	save_game()
		
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		save_game()

func save_game():
	var variables = $Level/Level.save()
	variables["level"] = level_path
	
	var save_file = File.new()
	save_file.open("user://ld41.save", File.WRITE)
	save_file.store_line(to_json(variables))
	save_file.close()

func load_game():
	var save_file = File.new()
	save_file.open("user://ld41.save", File.READ)
	
	if not save_file.file_exists("user://ld41.save"):
		change_level("res://Levels/Level1.tscn")
		return
	else:
		var data = parse_json(save_file.get_line())
		var level = data["level"]
		data.erase("level")
		var args = data
		
		change_level(level, args)
	
	save_file.close()