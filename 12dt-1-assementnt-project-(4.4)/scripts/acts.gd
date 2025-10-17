extends Node2D

@onready var transition = $transition/AnimationPlayer

#Code that handles the scene transitions 
func _ready():
	if transition:
		transition.play("fade_out")
	else:
		print("⚠️ transition node not found!")
