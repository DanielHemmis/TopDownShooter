extends RigidBody2D

@onready var player = get_node("/root/Game/Player")
var health_amount : int = 10

func give_health():
	queue_free()
	player.gain_health(health_amount)
