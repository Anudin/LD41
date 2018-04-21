extends Control

signal text_command
signal queue_updated

onready var Main = $"/root/Main"

const SUBMIT = [KEY_ENTER, KEY_SPACE]
const DELETE = [KEY_BACKSPACE, KEY_DELETE]
const DEFAULT_TEXT = "Type command..."

var queue = []

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
				if not $TextDisplay.text == DEFAULT_TEXT:
					var command = $TextDisplay.text.to_lower()
					
					command = Main.verify_command(command)
					
					if command != null:
						if event.scancode == KEY_SPACE:
							queue.push_back(command)
							
							if queue.size() > 3:
								queue.pop_front()
								queue.resize(3)
							
							emit_signal("queue_updated", queue)
						else:
							emit_signal("text_command", command)
					else:
						$AnimationPlayer.play("typo")
					
					$TextDisplay.text = DEFAULT_TEXT
				else:
					submit_queue()
			elif DELETE.has(event.scancode):
				$TextDisplay.text = DEFAULT_TEXT
			elif event.scancode == KEY_ESCAPE:
				queue.clear()
				$TextDisplay.text = DEFAULT_TEXT
				emit_signal("queue_updated", queue)

func submit_queue():
	emit_signal("text_command", queue.pop_front())
	emit_signal("queue_updated", queue)