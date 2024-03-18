extends Area2D

func _process(_delta):
	look_at(get_global_mouse_position())

func shoot():
	const BULLET = preload("res://bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = %ShootingPoint.global_rotation	
	%ShootingPoint.add_child(new_bullet)
	%ShootSound.play()

func _on_timer_timeout():
	shoot()
