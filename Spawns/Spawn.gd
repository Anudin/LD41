extends Area2D

export var DESTROYABLE = false
export var SPAWN_SPEED_SECS = 2.5
export var MAX = 5

var AI = preload("res://AI/AI.tscn")

var spawned = 0
var destroyed = false

func get_remaining_spawns():
	return MAX - spawned

func _ready():
	$Timer.wait_time = SPAWN_SPEED_SECS
	
	if not DESTROYABLE:
		disconnect("area_entered", self, "_on_area_entered")

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_timeout():
	if spawned >= MAX:
		$Timer.stop()
		return
	
	$Body.play("open")
	var spawn = AI.instance()
	spawn.position = global_position
	$"/root/Main/Level/Level/AI".add_child(spawn)
	
	spawned += 1

func _on_area_entered(area):	
	destroy()

func destroy():
	$Timer.stop()
	z_index = -1
	destroyed = true
	$Body.play("explode")
	set_process(false)

func _on_animation_finished():
	if not destroyed:
		$Body.play("default")
	else:
		queue_free()
		get_parent().remove_child(self)
