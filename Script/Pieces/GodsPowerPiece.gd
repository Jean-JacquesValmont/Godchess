extends Node

var pieces = ["PawnBlack","PawnBlack2","PawnBlack3","PawnBlack4","PawnBlack5","PawnBlack6","PawnBlack7","PawnBlack8","KnightBlack","KnightBlack2","BishopBlack","BishopBlack2","RookBlack","RookBlack2"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Power of Gods
#God of Death
func enablePowerOfDeath(pieceName,playerID,chessBoard):
	if GlobalValueMenu.godSelectPlayer1 == "GodOfDeath":
		if "PawnWhite" in pieceName:
			GodOfDeathPower.deathPowerPawn(playerID, chessBoard)
		elif "KnightWhite" in pieceName:
			GodOfDeathPower.deathPower(playerID,7)
		elif "BishopWhite" in pieceName:
			GodOfDeathPower.deathPower(playerID,9)
		elif "RookWhite" in pieceName:
			GodOfDeathPower.deathPower(playerID,11)
		elif "QueenWhite" in pieceName:
			GodOfDeathPower.deathPower(playerID,13)

func deadPowerTimer():
	for p in pieces:
		var nameNodePiece = get_node("/root/Game/ChessBoard/" + pieces[p])
		if nameNodePiece != null:
			if nameNodePiece.get_node("Timer").visible == true and GlobalValueChessGame.turnWhite == true :
				nameNodePiece.timer -= 1
				nameNodePiece.get_node("Timer").text = str(nameNodePiece.timer)
			if nameNodePiece.timer == 0:
				nameNodePiece.chessBoard[nameNodePiece.i][nameNodePiece.j] = "0"
				nameNodePiece.queue_free()
