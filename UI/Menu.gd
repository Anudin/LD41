extends CanvasLayer

export(int) var selected = 0

# Implement in child
func execute():
	pass

func _ready():
	VisualServer.set_default_clear_color(Color(0, 0, 0, 1.0))
	get_child(selected).get_node("Selected").show()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func toggle_selected(index):
	var option = get_child(index)
	
	if index != selected:
		option.get_node("Selected").show()
	else:
		option.get_node("Selected").hide()

func _input(event):
	if not event is InputEventKey:
		return
	elif event.is_action_pressed("ui_accept"):
		execute()
	
	toggle_selected(selected)
	
	if event.is_action_pressed("ui_up"):
		selected = clamp(selected - 1, 0, get_child_count() - 1)
	if event.is_action_pressed("ui_down"):
		selected = clamp(selected + 1, 0, get_child_count() - 1)
	
	get_child(selected).get_node("Selected").show()
