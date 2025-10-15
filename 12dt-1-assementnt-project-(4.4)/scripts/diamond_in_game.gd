extends Node2D
@onready var diamond_con = get_node("/root/Node2D/Node2D/CharacterBody2D/Camera2D/CanvasLayer/diamond_Container")
@onready var global = get_node("/root/Global")
var diamond_collected = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	diamond_con.updateDiamonds(global.diamond_current)
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	Global.diamond_current += 1
	print("Collected diamond! Total:", Global.diamond_current)
	queue_free()
	pass # Replace with function body.
