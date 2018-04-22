extends Node2D

export var LAUNCH_CODE_LENGTH = 3
export var SLOWMOTION_MODIFIER = 0.3
export var SHOW_DIR_HINT = false

func before():
	set_process(true)

func _ready():
	set_process(false)

func after():
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
