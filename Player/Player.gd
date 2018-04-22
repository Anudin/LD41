extends AnimatedSprite

signal health_changed

var Bullet = preload("res://Player/Bullet.tscn")

const SPEED_MODIFIER = 60

var direction = Vector2(0,1)
var velocity = Vector2(0,0)
var last_position

var health = 100

func _ready():
	emit_signal("health_changed", health)

func _process(delta):
	last_position = position
	position += velocity * delta
	
	if velocity != Vector2(0,0):
		play("default")
	else:
		stop()

func _on_text_command(command):
	if command == "shoot":				
		var bullet = Bullet.instance()
		bullet.setup(direction)
		bullet.position = position
		$"/root/Main/Bullets".add_child(bullet)
	
	# Rotate labels so they face upside in case the player was moved
	$RightMarker.global_rotation = 0
	$LeftMarker.global_rotation = 0

func _on_hit():
	health -= 25
	emit_signal("health_changed", health)

func _on_area_shape_entered(area_id, area, area_shape, self_shape):	
	if area.is_in_group("walls"):
		position = last_position
		velocity = Vector2(0,0)

func change_movement(movement):
	if has_node("Movement"):
		$Movement.queue_free()
		remove_child($Movement)
	
	add_child(movement)