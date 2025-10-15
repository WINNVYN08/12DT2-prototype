extends Node
@onready var transition = $"../transition/AnimationPlayer"

func _on_area_2d_area_entered(area: Area2D) -> void:
	
	transition.play("fade_in")
	get_tree().change_scene_to_file("res://scenes/act_2.tscn")
	pass # Replace with function body.
