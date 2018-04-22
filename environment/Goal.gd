extends Area2D

signal player_arrived

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_area_entered(area):
	$CollisionShape2D.disabled = true
	emit_signal("player_arrived")
