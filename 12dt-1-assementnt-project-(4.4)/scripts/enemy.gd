extends CharacterBody2D

class_name  enemy_one

var speed = -20
var gravity = 900

var facing_right = false
var player: CharacterBody2D

#handles the basic enemy ai
func _process(delta):
	if !is_on_floor():
		velocity.y += gravity * delta
	
	if !$floor.is_colliding() or is_on_wall() and is_on_floor():
		_flip() 
	velocity.x = speed
	move_and_slide()
		
# handles fli0p
func _flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	if facing_right :
		speed = abs(speed)
	else:
		speed = abs(speed) * -1 
