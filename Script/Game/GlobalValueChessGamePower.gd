extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#All powers
func allPowerOfGods(chessBoard):
	powerOfDeathActived()
	powerOfTheSectActived(chessBoard)

#God of Death
func powerOfDeathActived():
	GodsPowerPiece.enablePowerOfDeathKing()

#God of the Sect
func powerOfTheSectActived(chessBoard):
	GodsPowerPiece.enablePowerOfSect(chessBoard)
