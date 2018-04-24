extends Node2D

# Next LD:
# State management... (scene switching, menus, ...)
# Better composition handling (also with regard towards state)
# Naming conventions
# Project structure
# Boolean toggle helper

# TODO: Particles - trails!, smoke, blood etc.

# Quirks: Can't rename folder (in use?)
# Quirks: Child remove doesn't work...
# Quirks: Area might be null

# Fix second "enter" to use pause screen - pause screen only works in 1,2,end
# Main menu: difficulty

# Save settings as soon as they're set and load from file.

var COMMANDS = []
const TEMP_COMMANDS = {"whatever": "shoot"}

var play_audio = true

var continue_game
var level_path

func toggle_audio():	
	if play_audio:
		AudioServer.set_bus_volume_db(0, -60)
	else:
		AudioServer.set_bus_volume_db(0, -3)

func pause():
	$PauseMenu.toggle_visibility()
	get_tree().paused = true

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		pause()

func _ready():
	randomize()
	
	var game_loaded = false
	
	if continue_game:
		game_loaded = load_game()
	if not game_loaded:
		change_level("res://Levels/Intro.tscn")
	
	_on_queue_updated([])
	update_temp_commands(TEMP_COMMANDS.keys()[0])

func setup(continue_game = false):
	self.continue_game = continue_game

#func _process(delta):
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
	$UI/PlayerHealth.value = clamp(health, 0, 100)

func restart_game():
	save_game()
	
	var main = load("res://Main.tscn").instance()
	main.continue_game = true
	main.play_audio = play_audio
	
	var root = $"/root"
	root.remove_child($"/root/Main")
	root.add_child(main)
	queue_free()

func change_level(path, args = null):
	level_path = path
	var level = load(path).instance()
	
	if $AudioStreamPlayer.stream != level.BACKGROUND_MUSIC:
		$AudioStreamPlayer.stream = level.BACKGROUND_MUSIC
		$AudioStreamPlayer.play()
	
	if args != null:
		for variable in args.keys():
			level.set(variable, args[variable])
	
	if not has_node("Level/Level"):
		$Level.add_child(level)
	else:
		$Level.add_child(level)
		save_game()
	
		
#func _notification(what):
#	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
#		save_game()

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
		return false
	else:
		var data = parse_json(save_file.get_line())
		var level = data["level"]
		data.erase("level")
		var args = data
		
		change_level(level, args)
	
	save_file.close()
	
	return true