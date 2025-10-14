extends Node

@onready var player = $".."
@onready var diamond_con = get_node("/root/Node2D/Node2D/CharacterBody2D/Camera2D/CanvasLayer/diamond_Container")

func _ready():
	if not diamond_con == null:
		diamond_con.updateDiamonds(1)
