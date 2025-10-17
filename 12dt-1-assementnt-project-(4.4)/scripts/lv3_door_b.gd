extends Node
@onready var transition = $"../transition/AnimationPlayer"

func _on_area_2d_area_entered(area: Area2D) -> void:
	transition.play("fade_in")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/act_6.tscn")
	pass # Replace with function body.
