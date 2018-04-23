extends Sprite

var AI = preload("res://AI/AI.gd")

var penetrate_enemy = false

var direction = Vector2(0,0)
var speed = 800

func _ready():
	penetrate_enemy = $"/root/Main/Level/Level".PENETRATE_ENEMY

func setup(direction):
	self.direction = direction

func _process(delta):
	position += direction * speed * delta

func _on_screen_exited():
	queue_free()

func _on_area_shape_entered(area_id, area, area_shape, self_shape):	
	if (area.get_parent().is_in_group("enemies") and area_shape == area.get_parent().collider_id and not penetrate_enemy) or \
	area.is_in_group("walls") or \
	area.get_parent().is_in_group("enemy_spawn"):
		$Area2D/CollisionShape2D.disabled = true
		queue_free()
