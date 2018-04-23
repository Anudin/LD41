extends Node

onready var Player = $"/root/Main/Player"
onready var Parent = get_parent()

var last_position = Vector2(0,0)
var speed = 30

func _ready():
	pass

func _process(delta):	
	var angle_to_player = rad2deg(Parent.get_angle_to(Player.position))
	var modifiers = 1
	
	if Player.velocity == Vector2(0,0):
		modifiers *= $"/root/Main/Level/Level".SLOWMOTION_MODIFIER
	
	Parent.position += (Player.position - Parent.position).normalized() * speed * delta * modifiers

func _on_animation_finished():
	pass

func explode():
	set_process(false)
	Parent.z_index = -1
	Parent.get_node("Shadow").hide()
	Parent.get_node("AnimationPlayer").stop()
	Parent.get_node("Area2D/CollisionShape2D").disabled = true
	Parent.get_node("Area2D/ExplosionTrigger").disabled = true
	Parent.alive = false
	Parent.rotate(deg2rad(randi()%135-90))
	Parent.play("explode")

# TODO: Remove dev cheat
func _input(event):
	if event is InputEventKey and event.scancode == KEY_F1:
		explode()

func _on_area_shape_entered(area_id, area, area_shape, self_shape):
	match self_shape:
		Parent.collider_id:
			explode()
		Parent.explosion_trigger_id:
			if area != Player.get_node("Area2D"):
				return
			
			explode()
			Player._on_hit()
