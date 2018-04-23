extends Node2D

signal level_finished

export var LAUNCH_CODE_LENGTH = 3
export var SLOWMOTION_MODIFIER = 0.33
export var SHOW_DIR_HINT = false
export var PENETRATE_ENEMY = false
export(PackedScene) var Movement
export(String) var FOLLOWING_SCENE_PATH
export(AudioStream) var BACKGROUND_MUSIC

onready var timeout = Timer.new()

# Implement in each script
func win_condition():
	pass

# Implement if needed
func save():
	return {}

func before():
	pass

func _ready():	
	add_child(timeout)
	timeout.wait_time = 1.5
	timeout.connect("timeout", self, "_on_timeout")

	$"/root/Main/Player/LeftMarker".visible = SHOW_DIR_HINT
	$"/root/Main/Player/RightMarker".visible = SHOW_DIR_HINT
	$"/root/Main/Player".change_movement(Movement.instance())
	
	connect("level_finished", $"/root/Main", "change_level")
	
	before()

func after():
	queue_free()
	get_parent().remove_child(self)

func _process(delta):
	if win_condition() and timeout.is_stopped():
		timeout.start()

func _on_timeout():
	set_process(false)
	emit_signal("level_finished", FOLLOWING_SCENE_PATH)