extends Area2D

const SPEED : float = 1000.0
const RANGE : float = 1200.0
var travelled_distance : float = 0.0

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	travelled_distance += SPEED * delta
	if travelled_distance > RANGE:
		queue_free()

func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.call_deferred("take_damage")
