extends HBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func updateDiamonds(diamond_amount: int):
	var diamond = get_children()
	
	for i in range(diamond_amount):
		diamond[1].update(true)
		
	for i in range(diamond_amount, diamond.size()):
		diamond[1].update(false)
