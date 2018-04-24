extends Node2D

signal level_finished

export var LAUNCH_CODE_LENGTH = 3
export var SLOWMOTION_MODIFIER = 0.33
export var SHOW_DIR_HINT = false
export var PENETRATE_ENEMY = false
export(PackedScene) var Movement
export(String) var FOLLOWING_SCENE_PATH
export(AudioStream) var BACKGROUND_MUSIC

var restart_game = false

# ABSTRACT
func save():
	return {}

func before():
	pass

func after():
	pass

func delete():
	queue_free()
	get_parent().remove_child(self)
	
func _ready():
	$"/root/Main/Player".health = 100
	$"/root/Main/Player/LeftMarker".visible = SHOW_DIR_HINT
	$"/root/Main/Player/RightMarker".visible = SHOW_DIR_HINT
	$"/root/Main/Player".change_movement(Movement.instance())
	
	$"/root/Main/Player".connect("player_died", self, "_on_player_died")
	connect("level_finished", $"/root/Main", "change_level")
	
	before()

func _on_player_died():
	restart_game = true

func _process(delta):
	if win_condition():
		after()
		emit_signal("level_finished", FOLLOWING_SCENE_PATH)
	elif restart_game:
		after()
		$"/root/Main".call_deferred("restart_game")