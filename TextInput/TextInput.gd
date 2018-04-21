extends Control

signal text_command

const COMMANDS = ["up", "down", "left", "right", "stop"]

const DEFAULT_TEXT = "Type command..."

func _ready():
	$TextDisplay.text = DEFAULT_TEXT

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _input(event):
	if event is InputEventKey:
		keyboard_input(event)

func keyboard_input(event):	
	if event.is_pressed() and not event.is_echo():
		if (event.unicode >= "a".ord_at(0) and event.unicode <= "z".ord_at(0)) or \
		(event.unicode >= "A".ord_at(0) and event.unicode <= "Z".ord_at(0)):
			var typed_char = char(event.unicode)
						
			if $TextDisplay.text == DEFAULT_TEXT:
				$TextDisplay.text = typed_char
			else:
				$TextDisplay.text += typed_char
		else:
			if event.scancode == KEY_ENTER or event.scancode == KEY_SPACE:
				var command = $TextDisplay.text.to_lower()
				
				if COMMANDS.has(command):
					emit_signal("text_command", command)
				else:
					$AnimationPlayer.play("typo")
				
				$TextDisplay.text = DEFAULT_TEXT
