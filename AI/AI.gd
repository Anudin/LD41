extends AnimatedSprite

onready var collider_id = $Area2D/CollisionShape2D.get_position_in_parent()
onready var explosion_trigger_id = $Area2D/ExplosionTrigger.get_position_in_parent()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):	
#	pass

func _on_screen_collision():
	pass
