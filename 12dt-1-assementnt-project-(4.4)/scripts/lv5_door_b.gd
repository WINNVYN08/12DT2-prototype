extends Node

@onready var transition = $"../transition/AnimationPlayer"
func _on_area_2d_area_entered(area: Area2D) -> void:
	get_tree().change_scene_to_file("res://scenes/act_8.tscn")
	pass # Replace with function body.
