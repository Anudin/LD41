extends "res://Levels/Level.gd"

var Spawn = preload("res://Spawns/Spawn.tscn")

var skip_tutorial = false

var score = 0
var wave = 0

# max spawns, max spawns per spawn, spawn_speed, slowmo mod, launcode length
var waves = [
#0  1    2  3   4   5
[3, 999, 4, 5, .33, 3],
[4, 999, 4, 5, .33, 3],
[5, 999, 4, 5, .33, 3],
[6, 999, 4, 5, .33, 3],
[7, 999, 4, 5, .33, 3]
]

# Replace timer with condition.
func next_wave():
	if wave < waves.size():
		wave += 1
	
	load_wave()

func load_wave():
	SLOWMOTION_MODIFIER = waves[wave][4]
	LAUNCH_CODE_LENGTH = waves[wave][5]

func increase_score():
	score += 5
	$ScoreLayer/Score.text = str(score)
	$ScoreAnimation.play("score_effect")

func save():
	return {"skip_tutorial": $TutorialText.played}

func before():
	$"/root/Main/Player/Camera2D".current = true
	
	if skip_tutorial:
		$TutorialText.hide()
		return
	
	get_tree().paused = true

func win_condition():
	return false

func _ready():
	load_wave()

func _process(delta):	
	while get_tree().get_nodes_in_group("enemy_spawn").size() < waves[wave][0]:
		var spawn = Spawn.instance()
		spawn.SPAWN_SPEED_SECS = waves[wave][2]
		spawn.MAX = waves[wave][1]
		
		var spawn_position = null
		
		while spawn_position == null or \
		spawn_position.get_child_count() != 0:
			spawn_position = $Spawns.get_child(randi()%$Spawns.get_child_count())
		
		spawn_position.add_child(spawn)
