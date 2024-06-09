extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#All powers
func allPowerOfGods():
	deadTimerPowerActived()

#God of Death
func deadTimerPowerActived():
	GodsPowerPiece.deadPowerTimer()
	GodsPowerPiece.enablePowerOfDeathKing()
