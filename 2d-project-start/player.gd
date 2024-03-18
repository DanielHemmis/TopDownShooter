extends CharacterBody2D

signal health_depleted

var level : int = 1
var experience : float = 0.0
var experience_needed : float = 100.0
var max_health : float = 100.0
var health : float = 100.0
const DAMAGE_RATE : float = 5.0

func _ready():
	%HealthBar.max_value = max_health
	%HealthBarLabel.text = str(int(health), " / ", int(max_health))
	%CharacterLevelLabel.text = str("Character Level: ", level)

func _process(_delta):
	%HealthBar.value = health
	%HealthBar.max_value = max_health
	%HealthBarLabel.text = str(int(health), " / ", int(max_health))
	%ExpBar.value = experience
	%ExpBar.max_value = experience_needed
	%CharacterLevelLabel.text = str("Character Level: ", level)

func _physics_process(delta):
	var direction : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * 600.0
	move_and_slide()

	if velocity.length() > 0.0:
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
		
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		
		if health <= 0.0:
			health_depleted.emit()

func add_experience(amount):
	experience += amount
	print(str(experience, " / ", int(experience_needed)))
	
	if experience >= experience_needed:
		add_level()
		experience = 0.0

func add_level():
	level += 1
	print(str("Level: ", level))
	experience_needed *= 1.1
	max_health = max_health * 1.05
	
func gain_health(amount):
	if health + amount >= max_health:
		health = max_health
	else:
		health += amount
