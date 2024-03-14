extends CharacterBody2D

@onready var player = get_node("/root/Game/Player")
var health : int = 3
var experience_given : int = 10

func _ready():
	%Slime.play_walk()

func _physics_process(_delta):
	var direction : Vector2 = global_position.direction_to(player.global_position)
	velocity = direction * 300.0
	move_and_slide()

func take_damage():
	health -= 1
	%Slime.play_hurt()
	
	if health <= 0:
		queue_free()
		
		get_tree().call_group("player", "add_experience", experience_given)
		
		const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke = SMOKE_SCENE.instantiate()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
