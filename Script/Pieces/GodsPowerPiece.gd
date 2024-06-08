extends Node

var pieces = ["PawnBlack","PawnBlack2","PawnBlack3","PawnBlack4","PawnBlack5","PawnBlack6","PawnBlack7","PawnBlack8","KnightBlack","KnightBlack2","BishopBlack","BishopBlack2","RookBlack","RookBlack2"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Power of Gods
#God of Death
func enablePowerOfDeath(pieceName,playerID,chessBoard):
	print("In enablePowerOfDeath: ", " pieceName: ", pieceName, " playerID: ", playerID,)
	if GlobalValueMenu.godSelectPlayer1 == "GodOfDeath":
		if "PawnWhite" in pieceName:
			GodOfDeathPower.deathPowerPawn(playerID, chessBoard)
		elif "KnightWhite" in pieceName:
			print("In enablePowerOfDeath KnightWhite")
			GodOfDeathPower.deathPower(playerID,7)
		elif "BishopWhite" in pieceName:
			GodOfDeathPower.deathPower(playerID,9)
		elif "RookWhite" in pieceName:
			GodOfDeathPower.deathPower(playerID,11)
		elif "QueenWhite" in pieceName:
			GodOfDeathPower.deathPower(playerID,13)

func deadPowerTimer():
	for piece in pieces:
		var path = "/root/Game/ChessBoard/" + piece
		if has_node(path) == true:
			var nameNodePiece = get_node(path)
			if nameNodePiece != null:
				if nameNodePiece.get_node("Timer").visible == true and GlobalValueChessGame.turnWhite == true :
					nameNodePiece.timer -= 1
					nameNodePiece.get_node("Timer").text = str(nameNodePiece.timer)
				if nameNodePiece.timer == 0:
					nameNodePiece.chessBoard[nameNodePiece.i][nameNodePiece.j] = "0"
					nameNodePiece.queue_free()
		elif has_node(path) == false:
			continue
