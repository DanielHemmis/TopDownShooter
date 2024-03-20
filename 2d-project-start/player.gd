extends CharacterBody2D

signal health_depleted

var level : int = 1
var experience : float = 0.0
var experienceNeeded : float = 100.0
var maxHealth : float = 100.0
var health : float = 100.0
const DAMAGE_RATE : float = 5.0

#movement
@export var maxSpeed : float = 250
@export var acceleration : float = 1000

func _ready():
	%HealthBar.max_value = maxHealth
	%HealthBarLabel.text = str(int(health), " / ", int(maxHealth))
	%CharacterLevelLabel.text = str("Character Level: ", level)

func _process(_delta):
	%HealthBar.value = health
	%HealthBar.max_value = maxHealth
	%HealthBarLabel.text = str(int(health), " / ", int(maxHealth))
	%ExpBar.value = experience
	%ExpBar.max_value = experienceNeeded
	%CharacterLevelLabel.text = str("Character Level: ", level)

func _physics_process(delta):
	var direction : Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity.x = move_toward(velocity.x, maxSpeed * direction.x, acceleration * delta)
	velocity.y = move_toward(velocity.y, maxSpeed * direction.y, acceleration * delta)
	move_and_slide()

	if velocity.length() > 0.0:
		%PlayerBody.play_walk_animation()
	else:
		%PlayerBody.play_idle_animation()
	
	if Input.is_action_just_pressed("move_left"):
		%PlayerBody.get_node("Sprite").flip_h = true
	if Input.is_action_just_pressed("move_right"):
		%PlayerBody.get_node("Sprite").flip_h = false
		
	var overlapping_mobs = %HurtBox.get_overlapping_bodies()
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		
		if health <= 0.0:
			health_depleted.emit()

func add_experience(amount):
	experience += amount
	print(str(experience, " / ", int(experienceNeeded)))
	
	if experience >= experienceNeeded:
		add_level()
		experience = 0.0

func add_level():
	level += 1
	print(str("Level: ", level))
	experienceNeeded *= 1.1
	maxHealth = maxHealth * 1.05
	
func gain_health(amount):
	if health + amount >= maxHealth:
		health = maxHealth
	else:
		health += amount

func _on_pick_up_radius_body_entered(body):
	if body.has_method("give_health"):
		body.give_health()
