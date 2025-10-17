extends CharacterBody2D
@export var double_jump_speed = -150
@export var speed = 100
@export var dash_speed = 400
@export var jump_speed = -250
@export var gravity = 1200
@onready var _animated_sprite = $AnimatedSprite2D
@export var stomp_speed = 400
var initial_gravity = 700
@export_range(0.0, 1.0) var walk_friction = 0.2
@export_range(0.0 , 1.0) var walk_acceleration = 0.3
var acceleration = 0
var friction = 0
var slide_direction = 0
var sliding = false
@export_range(0.0 , 1.0) var slide_friction = 0.009
@export var wall_jump_pushback = 200
@export var wall_jump_speed = -190
@export var wall_fall_speed = 50
var diamond = 0
var health = 0
var max_health = 100
var wall_jump = true 
var variable_jump = true
var dash_ready = false
var double_jump_ready = false
var start_position = Vector2.ZERO
var jumping = false
var can_die = true
var coyote_frames = 60
var coyote = false
var last_floor = false  


func _ready():
	#setting the cayote time
	$CoyoteTimer.wait_time = coyote_frames / 60.0
	health = max_health
	pass


func _physics_process(delta):
	velocity.y += gravity * delta
	
	# defining dir
	var dir = Input.get_axis("left", "right")
	
	# this code is for the slide
	if  not Input.is_action_pressed("down")  :
		sliding = false
		if dir != 0: # if pressing either left or right 
			friction = walk_friction  
			acceleration = walk_acceleration 
			velocity.x = lerp(velocity.x, dir * speed, acceleration)
		
		else:
			velocity.x = lerp(velocity.x,0.0 , friction) # slide movement
	
	#flipping the chacter sprite
	if dir <0 :
		_animated_sprite.flip_h = true
	elif dir >0 :
		_animated_sprite.flip_h = false
		
	if Input.is_action_just_pressed("down") and not is_on_floor():
		velocity.y = stomp_speed
		velocity.x = 0
		
	if Input.is_action_pressed("down") and is_on_floor() and dir != 0 and not sliding :
		dash_ready = false
		double_jump_ready = false
		wall_jump = false
		slide_direction = sign(dir)
		sliding = true
		friction = walk_friction
		
	if abs(velocity.x) < 0.5:
		sliding = false
		velocity.x = 0.0

	if velocity.x != 0 and ! sliding and is_on_floor():
		_animated_sprite.play("run")	
		
			
	if velocity.x == 0 and is_on_floor():
		_animated_sprite.play("idle")		
		
	# setting all the states that are needed when player touches floor
	if is_on_floor():
		jumping = false
		dash_ready = false
		double_jump_ready = false
		variable_jump = true
		wall_jump = true

	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote):
		$"../sounds/JumpSound".play()	
		velocity.y = jump_speed
		_animated_sprite.play("jump")
		jumping = true
		dash_ready = true
		double_jump_ready = true

	if Input.is_action_just_released("jump")and variable_jump == true:
		velocity.y *= 0.4 
		variable_jump = false 
	elif Input.is_action_just_pressed("jump") and not is_on_floor() and double_jump_ready:
		$"../sounds/DoubleJumpSound".play()	
		velocity.y = double_jump_speed
		_animated_sprite.play("double-Jump")
		double_jump_ready = false
		

	if Input.is_action_just_pressed("dash") and dash_ready:
		$"../sounds/DashSound".play()
		dash_ready = false
		velocity.x = dir * (dash_speed * 2)
		velocity.y = -velocity.y /2
		
	if Input.is_action_just_pressed("jump") and is_on_wall() and wall_jump and ! is_on_floor():
			velocity.y = wall_jump_speed
			wall_jump = false
			velocity.x = get_wall_normal().x * wall_jump_pushback
			double_jump_ready = true
	
	if is_on_wall() and velocity.y > 0:
		gravity = wall_fall_speed
	else:
		gravity = initial_gravity
		
	if !is_on_floor() and last_floor and !jumping:
		coyote = true
		$CoyoteTimer.start()
		

	if Input.is_action_just_pressed("return"):
		get_tree().change_scene_to_file("res://scenes/act_1.tscn")
			
		
	last_floor = is_on_floor()
	player_health()
	apply_floor_snap() 
	move_and_slide()
	
	

func player_health():
	if can_die == true:
		if health <= 0 :
			speed = 0 
			jump_speed = 0
			_animated_sprite.play("death")	
			$"../sounds/DeathSound".play()	
			can_die = false
			_death()
		
	


func _on_area_2d_body_entered(body: Node) -> void:
	if body.has_meta("enemy"):
		health -= 20
		$"../sounds/HurtSound".play()
	if body.has_meta("diamond"):
		diamond += 1
		$"../sounds/HurtSound".play()
		
	pass # Replace with function body.
	

func _on_coyote_timer_timeout() -> void:
	coyote = false
	pass # Replace with function body.

func _death():
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://scenes/Game_over_screen.tscn")
