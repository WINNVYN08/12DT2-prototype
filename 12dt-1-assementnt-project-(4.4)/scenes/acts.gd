extends Node2D

@onready var transition = get_node_or_null("transition/AnimationPlayer")

func _ready():
	if transition:
		transition.play("fade_out")
	else:
		print("⚠️ transition node not found!")
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
