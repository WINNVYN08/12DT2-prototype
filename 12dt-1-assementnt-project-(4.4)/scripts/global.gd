extends Node

var diamond_current = 0
@onready var player = $".."
@onready var diamond_con = get_node("/root/Node2D/Node2D/CharacterBody2D/Camera2D/CanvasLayer/diamond_Container")
@onready var in_game_diamond = get_node("/root/Global")


func _process(delta: float) -> void:
	var diamond_con = get_node_or_null("/root/Node2D/Node2D/CharacterBody2D/Camera2D/CanvasLayer/diamond_Container")
	if diamond_con:
		diamond_con.updateDiamonds(diamond_current)
		print(diamond_current)
	else:
		print("diamond_Container not found or was freed!")
	
	if diamond_current >= 3 :
			get_tree().change_scene_to_file("res://scenes/win_screen.tscn")
