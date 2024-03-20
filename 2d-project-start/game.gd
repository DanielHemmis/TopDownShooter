extends Node2D

var time : float = 0.0
var minutes : int = 0
var seconds : int = 0

func _ready():
	for i in 5:
		spawn_mob()

func _process(delta) -> void:
	time += delta
	seconds = fmod(time, 60)
	minutes = fmod(time, 3600) / 60
	%Minutes.text = "%02d:" % minutes
	%Seconds.text = "%02d" % seconds

func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_mob.global_position = %PathFollow2D.global_position
	add_child(new_mob)

func _on_timer_timeout():
	spawn_mob()

func _on_player_health_depleted():
	%Player.get_node("PlayerBody").play_death_animation()
	
	set_process(false)
	%GameOver.visible = true
	get_tree().paused = true
