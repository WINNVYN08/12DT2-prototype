extends Node2D

@onready var path_follow_1 : PathFollow2D = $Path2D/PathFollow1
@onready var path_follow_2 : PathFollow2D = $Path2D/PathFollow2

@export var speed = 2

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
	pass # Replace with function body.

func _process(delta: float) -> void:
	path_follow_1.progress += speed
	path_follow_2.progress += speed
