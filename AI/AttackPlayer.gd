extends Node

onready var Player = $"/root/Main/Player"
onready var Parent = get_parent()

var last_position = Vector2(0,0)
var speed = 30

func _ready():
	pass

func _physics_process(delta):
	var angle_to_player = rad2deg(Parent.get_angle_to(Player.position))
	var modifiers = 1
	
	if Player.velocity == Vector2(0,0):
		modifiers *= $"/root/Main/Level/Level".SLOWMOTION_MODIFIER
	
	Parent.position += (Player.position - Parent.position).normalized() * speed * delta * modifiers

func _on_animation_finished():
	if Parent.get_node("Body").animation == "explode":
		Parent.alive = false

# Switch on animation finish
func explode():
	set_process(false)
	set_physics_process(false)
	
	Parent.get_node("AudioStreamPlayer").play()
	Parent.get_node("Body").play("explode")
	Parent.get_node("AnimationPlayer").stop()
	
	Parent.z_index = -1
	Parent.rotate(deg2rad(randi()%135-90))
	Parent.get_node("CollisionShape2D").disabled = true
	Parent.get_node("ExplosionTrigger").disabled = true
	Parent.get_node("Shadow").hide()

func _on_area_shape_entered(area_id, area, area_shape, self_shape):
	match self_shape:
		Parent.collider_id:
			explode()
		Parent.explosion_trigger_id:
			if area != Player:
				return
			
			explode()
			Player._on_hit()
