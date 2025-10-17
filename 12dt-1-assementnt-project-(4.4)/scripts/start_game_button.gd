extends Node2D


@export var speed = 2

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
	pass # Replace with function body.
