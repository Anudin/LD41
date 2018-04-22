extends AnimatedSprite

signal health_changed

var Bullet = preload("res://Player/Bullet.tscn")

const SPEED_MODIFIER = 60

var direction = Vector2(0,1)
var velocity = Vector2(0,0)

var health = 100

func _ready():
	emit_signal("health_changed", health)

func _process(delta):
	position += velocity * delta

func _on_text_command(command):
	movement(command)
	
	if command == "shoot":				
		var bullet = Bullet.instance()
		bullet.setup(direction)
		bullet.position = position
		$"/root/Main/Bullets".add_child(bullet)

func movement(command):
	if command == "left":
		rotate(deg2rad(-90))
		direction = direction.rotated(deg2rad(-90))
		velocity = direction * SPEED_MODIFIER
	elif command == "right":
		rotate(deg2rad(90))
		direction = direction.rotated(deg2rad(90))
		velocity = direction * SPEED_MODIFIER
	elif command == "go":
		velocity += direction * SPEED_MODIFIER
	elif command == "stop":
		velocity = Vector2(0,0)
	
	if velocity != Vector2(0,0):
		play("default")
	else:
		stop()

func _on_screen_collision():
	pass

func _on_hit():
	health -= 25
	emit_signal("health_changed", health)