extends Area2D

var display = true

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_area_entered(area):
	if display:
		var responses = get_parent().get_responses()
		
		if responses.size() > 0:
			var index = randi()%responses.size()
			$Text.text = responses[index]
			responses.remove(index)
			area.velocity = Vector2(0,0)
		
		$Text.show()
		$AnimationPlayer.play("fade_text")
		display = false
