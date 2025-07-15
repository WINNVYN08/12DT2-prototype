extends CharacterBody2D
@onready var sword_collision = $Sword_area/sword_collision
@export var double_jump_speed = -150
@export var speed = 200
@export var jump_speed = -200
@export var gravity = 1200
@export_range(0.0, 1.0) var friction = 0.3
@export_range(0.0 , 1.0) var acceleration = 0.09
@export var wall_jump_pushback = 800
@export var wall_jump_speed = -200
@export var wall_fall_speed = 300
var can_attack_again = true
var wall_jump = true 
var variable_jump = true
var dash_ready = false
var double_jump_ready = false
var start_position = Vector2.ZERO
var is_attacking = false


func _ready():
	sword_collision.disabled = true
	pass


func _physics_process(delta):
	velocity.y += gravity * delta

	var dir = Input.get_axis("left", "right")
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
	
	if dir <0 :
		sword_collision.position.x = -9
	elif dir >0 :
		sword_collision.position.x = 7

	if is_on_floor():
		dash_ready = false
		double_jump_ready = false
		variable_jump = true
		wall_jump = true

	if Input.is_action_just_pressed("jump") and is_on_floor ():
		velocity.y = jump_speed
		dash_ready = true
		double_jump_ready = true

	if Input.is_action_just_released("jump")and variable_jump == true:
		velocity.y *= 0.4 
		variable_jump = false 

	elif Input.is_action_just_pressed("jump") and not is_on_floor() and double_jump_ready:
		velocity.y = double_jump_speed
		double_jump_ready = false
		

	if Input.is_action_just_pressed("dash") and dash_ready:
		dash_ready = false
		velocity.x = dir * (speed * 5)
		velocity.y = -velocity.y /2
		
	if Input.is_action_just_pressed("jump") and is_on_wall() and wall_jump:
			velocity.y = wall_jump_speed
			wall_jump = false
			velocity.x = get_wall_normal().x * wall_jump_pushback
			double_jump_ready = true
	
	if is_on_wall() and velocity.y > 0:
		gravity = 200
	else:
		gravity = 1200
	if Input.is_action_just_pressed("attack") and not is_attacking:
		start_attack()
		

			
		
		
	print(velocity.x,velocity.y)
	apply_floor_snap() 
	move_and_slide()
	
func start_attack():
	if can_attack_again or is_attacking:
		is_attacking = true
		sword_collision.disabled = false
		can_attack_again = false
		attack_timer()

	
func attack_timer() -> void:
	await get_tree().create_timer(0.4).timeout
	is_attacking = false
	sword_collision.disabled = true	
	await get_tree().create_timer(0.4).timeout
	can_attack_again = true  # Re-enable attacking
	
