extends "res://Levels/Level.gd"

var Spawn = preload("res://Spawns/Spawn.tscn")

var skip_tutorial = false

var score = 0
var wave = 0

# max spawns, max spawns per spawn, spawn_speed, ?, slowmo mod, launcode length
var waves = [
[4, 3, 4, 5, .33, 3],
[4, 4, 4, 5, .33, 3],
[5, 3, 4, 5, .33, 4],
[5, 4, 4, 5, .33, 4],
[5, 3, 4, 5, .33, 5],
[5, 3, 4, 5, .5, 5],
[5, 3, 4, 5, 1, 5],
[5, 3, 4, 5, 2, 5],
[6, 3, 4, 5, 2, 5]
]

func next_wave():	
	if wave < waves.size() - 1:
		wave += 1
	
	for spawn_position in $Spawns.get_children():
		if spawn_position.get_children().size() != 0:
			var spawn = spawn_position.get_child(0)
			spawn.queue_free()
			spawn_position.remove_child(spawn)
	
	load_wave()

func load_wave():
	SLOWMOTION_MODIFIER = waves[wave][4]
	LAUNCH_CODE_LENGTH = waves[wave][5]

func after():
	OS.set_window_title("Last Score: " + str(score))

func _on_ai_died():
	increase_score()

func increase_score():
	score += 5
	$ScoreLayer/Score.text = str(score)
	$ScoreAnimation.play("score_effect")

func save():
	return {"skip_tutorial": $TutorialText.played}

func before():
	if skip_tutorial:
		$TutorialText.hide()
		return
	
	get_tree().paused = true

func win_condition():
	return false

func _ready():
	$"/root/Main/Player/Camera2D".current = true
	load_wave()

func wave_check():
	# Next wave
	for enemy in get_tree().get_nodes_in_group("enemies"):
		if enemy.alive:
			return
		
	for spawn in get_tree().get_nodes_in_group("enemy_spawn"):
		if spawn.get_remaining_spawns() != 0:
			return
	
	next_wave()

func _process(delta):
	# Spawn spawns
	while get_tree().get_nodes_in_group("enemy_spawn").size() < waves[wave][0]:		
		var spawn = Spawn.instance()
		spawn.SPAWN_SPEED_SECS = waves[wave][2]
		spawn.MAX = waves[wave][1]
		
		var spawn_position = null
		
		while spawn_position == null or \
		spawn_position.get_child_count() != 0:
			spawn_position = $Spawns.get_child(randi()%$Spawns.get_child_count())
		
		spawn_position.add_child(spawn)
	
	wave_check()
