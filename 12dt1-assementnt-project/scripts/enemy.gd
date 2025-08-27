extends CharacterBody2D

class_name  enemy_one

var speed = 30
var chasing = false
var dead = false 
var damaged = false
var damage_dealt = 3
var is_dealing_damage = false
var health = 10
var health_max = 10
var health_min = 0

var dir : Vector2
var gravity = 900
var knockback = 200
var is_roaming = true

var player: CharacterBody2D
var player_in_sight = false



func _process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
		velocity.x = 0
	move(delta)
	move_and_slide()
		
func _on_dir_timer_timeout() -> void:
	$dir_timer.wait_time = pick([1,1.5,2,3.5,0.1,4])
	if !chasing == true:
		dir =pick([Vector2.RIGHT,Vector2.LEFT])
		velocity.x = 0
	pass 
	
func move(delta):
	if !dead:
		if ! chasing:
			velocity += dir * speed * delta
		elif chasing and ! damaged:
			var player_dir = position.direction_to(player.position) * speed
			velocity.x = player_dir.x
			
		is_roaming = true
	elif dead:
		velocity.x = 0

func pick(array):
	array.shuffle()
	return array.front()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_meta("player_attack"):
		speed = 0
	pass # Replace with function body.
