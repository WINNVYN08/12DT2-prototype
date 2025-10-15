extends Node

var diamond_current = 0
@onready var player = $".."
@onready var diamond_con = get_node("/root/Node2D/Node2D/CharacterBody2D/Camera2D/CanvasLayer/diamond_Container")
@onready var in_game_diamond = get_node("/root/Node2D/Area2D")

func _ready():
	diamond_con.updateDiamonds(diamond_current)
	print(in_game_diamond) # Debug check

func _process(delta):
	if in_game_diamond and in_game_diamond.diamond_collected:
		diamond_current += 1
		diamond_con.updateDiamonds(diamond_current)
