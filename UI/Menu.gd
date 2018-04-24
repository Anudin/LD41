tool

extends CanvasLayer

export(int) var selected = 0

export var visible = true setget set_visible

# ABSTRACT
func execute():
	pass
	
func set_child_visibility():
	for child in get_children():
		child.visible = visible

func set_visible(value):
	visible = value
	set_child_visibility()

func toggle_visibility():	
	if visible:
		visible = false
		set_process_input(false)
	else:
		visible = true
		set_process_input(true)
	
	set_child_visibility()

func _ready():
	VisualServer.set_default_clear_color(Color(0, 0, 0, 1.0))
	$Options.get_child(selected).get_node("Selected").show()
	
	if not visible:
		set_process_input(false)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func toggle_selected(index):
	var option = $Options.get_child(index)
	
	if index != selected:
		option.get_node("Selected").show()
	else:
		option.get_node("Selected").hide()

func _input(event):
	get_tree().set_input_as_handled()
	
	if not event is InputEventKey:
		return
	elif event.is_action_pressed("ui_accept"):
		execute()
	
	toggle_selected(selected)
	
	if event.is_action_pressed("ui_up") or event.is_action_pressed("ui_left"):
		selected = clamp(selected - 1, 0, $Options.get_child_count() - 1)
	if event.is_action_pressed("ui_down") or event.is_action_pressed("ui_right"):
		selected = clamp(selected + 1, 0, $Options.get_child_count() - 1)
	
	$Options.get_child(selected).get_node("Selected").show()
