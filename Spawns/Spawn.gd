extends AnimatedSprite

export var SPAWN_SPEED_SECS = 2.5
export var MAX = 5

var AI = preload("res://AI/AI.tscn")

var spawned = 0

func _ready():
	$Timer.wait_time = SPAWN_SPEED_SECS

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_animation_finished():
	play("default")

func _on_timeout():
	if spawned >= MAX:
		return
	
	play("open")
	var spawn = AI.instance()
	spawn.position = position
	$"/root/Main/AI".add_child(spawn)
	
	spawned += 1
