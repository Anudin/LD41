extends Control

signal text_command

onready var Main = get_node("/root/Main")

const SUBMIT = [KEY_ENTER, KEY_SPACE]
const DELETE = [KEY_BACKSPACE, KEY_DELETE]
const DEFAULT_TEXT = "Type command..."

func _ready():
	$TextDisplay.text = DEFAULT_TEXT

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
			if SUBMIT.has(event.scancode):
				var command = $TextDisplay.text.to_lower()
				
				if Main.verify_command(command):
					emit_signal("text_command", command)
				else:
					$AnimationPlayer.play("typo")
				
				$TextDisplay.text = DEFAULT_TEXT
			elif DELETE.has(event.scancode):
				$TextDisplay.text = DEFAULT_TEXT
