extends CharacterBody2D

@export var double_jump_speed = -900
@export var speed = 700
@export var jump_speed = -700
@export var gravity = 2200
@export_range(0.0, 1.0) var friction = 0.3
@export_range(0.0 , 1.0) var acceleration = 0.09
@export var spring: float = 280.0
@export var damp: float = 7.0
@export var velocity_multiplier: float = 3000
  
var displacement: float = 0.0 
var oscillator_velocity: float = 0.0

var variable_jump = true
var dash_ready = false
var double_jump_ready = false
var start_position = Vector2.ZERO


func _ready():
	pass


func _physics_process(delta):
	velocity.y += gravity * delta

	var dir = Input.get_axis("left", "right")
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)

	if is_on_floor():
		dash_ready = false
		double_jump_ready = false
		variable_jump = true

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
		
	print(velocity.x)
	apply_floor_snap() 
	move_and_slide()
