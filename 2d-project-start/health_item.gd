extends Area2D

var health_amount : int = 10

func _on_body_entered(body):
	queue_free()
	if body.has_method("gain_health"):
		body.gain_health(health_amount)
