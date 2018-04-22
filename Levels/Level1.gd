extends "res://Levels/Level.gd"

var RelativeMovement = preload("res://Player/RelativeMovement.tscn")

func _ready():
	._ready()
	
	$"/root/Main/Player".add_child(RelativeMovement.instance())

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
