extends AnimatedSprite

signal health_changed

var Bullet = preload("res://Player/Bullet.tscn")

const SPEED_MODIFIER = 60

var direction = Vector2(0,1)
var velocity = Vector2(0,0)
var last_position

var health = 100 setget set_health
var reset_position = false
var dead = false

func set_health(value):
	health = value
	emit_signal("health_changed", health)

func _ready():
	emit_signal("health_changed", health)

func _process(delta):
	while(reset_position and $Area2D.get_overlapping_areas().size() != 0):
		position -= direction
		return
	
	last_position = position
	position += velocity * delta
	
	if velocity != Vector2(0,0):
		play("default")
	elif animation == "default":
		stop()
		
	# Rotate labels so they face upside in case the player was moved
	$RightMarker.global_rotation = 0
	$LeftMarker.global_rotation = 0

func _on_text_command(command):
	if command == "shoot":				
		var bullet = Bullet.instance()
		bullet.setup(direction)
		bullet.position = position
		$"/root/Main/Bullets".add_child(bullet)

func _on_hit():
	health -= 25
	emit_signal("health_changed", health)
	
	if health <= 0:
		dead = true
		velocity = Vector2(0,0)
		play("explode")

func _on_area_shape_entered(area_id, area, area_shape, self_shape):	
	if area.is_in_group("walls"):
		velocity = Vector2(0,0)
		reset_position = true

func change_movement(movement):
	if has_node("Movement"):
		$Movement.queue_free()
		remove_child($Movement)
	
	add_child(movement)

func _on_animation_finished():
	if dead and animation == "explode":
		$"/root/Main".player_died()


func _on_Area2D_area_shape_exited(area_id, area, area_shape, self_shape):
	if area.is_in_group("walls"):
		reset_position = false
