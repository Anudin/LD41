extends Node2D

signal level_finished

export var LAUNCH_CODE_LENGTH = 3
export var SLOWMOTION_MODIFIER = 0.3
export var SHOW_DIR_HINT = false
export(PackedScene) var Movement

func before():
	pass

func _ready():
	$"/root/Main/Player/LeftMarker".visible = SHOW_DIR_HINT
	$"/root/Main/Player/RightMarker".visible = SHOW_DIR_HINT
	$"/root/Main/Player".change_movement(Movement.instance())
	
	connect("level_finished", $"/root/Main", "change_level")

func after():
	queue_free()
	get_parent().remove_child(self)

func _process(delta):
	if win_condition():
		set_process(false)
		emit_signal("level_finished", "res://Levels/Level2.tscn")
