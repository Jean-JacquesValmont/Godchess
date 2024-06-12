extends Node

var pieces = ["PawnBlack","PawnBlack2","PawnBlack3","PawnBlack4","PawnBlack5","PawnBlack6","PawnBlack7","PawnBlack8","KnightBlack","KnightBlack2","BishopBlack","BishopBlack2","RookBlack","RookBlack2","QueenBlack"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reverseCoordonatesPieceI(pieceColor):
	match pieceColor.i:
		2:
			return 9
		3:
			return 8
		4:
			return 7
		5:
			return 6
		6:
			return 5
		7:
			return 4
		8:
			return 3
		9:
			return 2
			
func reverseCoordonatesPieceJ(pieceColor):
	match pieceColor.j:
		2:
			return 9
		3:
			return 8
		4:
			return 7
		5:
			return 6
		6:
			return 5
		7:
			return 4
		8:
			return 3
		9:
			return 2

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

func enablePowerOfDeathKing():
	if GlobalValueMenu.godSelectPlayer1 == "GodOfDeath":
		if GlobalValueChessGame.checkWhite == true:
			var playerIDKingBlack = get_node("/root/Game/ChessBoard/KingBlack").playerID
			GodOfDeathPower.deathPowerKing(playerIDKingBlack)

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
					if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
						GlobalValueChessGame.chessBoard[nameNodePiece.i][nameNodePiece.j] = "0"
						nameNodePiece.queue_free()
					elif OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1:
						var coordonatesReverseI = reverseCoordonatesPieceI(nameNodePiece)
						var coordonatesReverseJ = reverseCoordonatesPieceJ(nameNodePiece)
						GlobalValueChessGame.chessBoard[coordonatesReverseI][coordonatesReverseJ] = "0"
						nameNodePiece.queue_free()
		elif has_node(path) == false:
			continue
