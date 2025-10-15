extends Node

var diamond_current = 0
@onready var player = $".."
@onready var diamond_con = get_node("/root/Node2D/Node2D/CharacterBody2D/Camera2D/CanvasLayer/diamond_Container")
@onready var in_game_diamond = get_node("/root/Global")


func _process(delta: float) -> void:
	diamond_con.updateDiamonds(diamond_current)
	print(diamond_current) 
