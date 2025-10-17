extends Node2D
@onready var diamond_con = get_node("/root/Node2D/Node2D/CharacterBody2D/Camera2D/CanvasLayer/diamond_Container")
@onready var global = get_node("/root/Global")
var diamond_collected = false
# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	diamond_con.updateDiamonds(global.diamond_current)
	
	pass

# handles the diamond collection collision
func _on_area_2d_area_entered(area: Area2D) -> void:
	global.diamond_current += 0.5
	print("Collected diamond! Total:", global.diamond_current)
	#queue_free()
	hide()
	pass # Replace with function body.
