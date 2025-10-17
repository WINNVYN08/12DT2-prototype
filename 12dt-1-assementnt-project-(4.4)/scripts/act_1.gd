extends Node2D

@onready var transition = $transition/AnimationPlayer

#Code that handles the scene transitions 
func _ready() -> void:
	transition.play("fade_out")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
