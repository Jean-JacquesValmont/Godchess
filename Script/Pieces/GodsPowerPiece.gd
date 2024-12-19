extends Node

var piecesWhiteWithoutKing = ["PawnWhite","PawnWhite2","PawnWhite3","PawnWhite4","PawnWhite5","PawnWhite6","PawnWhite7","PawnWhite8","KnightWhite","KnightWhite2","BishopWhite","BishopWhite2","RookWhite","RookWhite2","QueenWhite"]
var piecesBlackWithoutKing = ["PawnBlack","PawnBlack2","PawnBlack3","PawnBlack4","PawnBlack5","PawnBlack6","PawnBlack7","PawnBlack8","KnightBlack","KnightBlack2","BishopBlack","BishopBlack2","RookBlack","RookBlack2","QueenBlack"]

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

func decreaseTimer():
	var allPieces = ["PawnBlack","PawnBlack2","PawnBlack3","PawnBlack4","PawnBlack5","PawnBlack6","PawnBlack7","PawnBlack8","KnightBlack","KnightBlack2","BishopBlack","BishopBlack2","RookBlack","RookBlack2","QueenBlack","KingBlack",
		"PawnWhite","PawnWhite2","PawnWhite3","PawnWhite4","PawnWhite5","PawnWhite6","PawnWhite7","PawnWhite8","KnightWhite","KnightWhite2","BishopWhite","BishopWhite2","RookWhite","RookWhite2","QueenWhite","KingWhite"]
		
	for piece in allPieces:
		var path = "/root/Game/ChessBoard/" + piece
		if has_node(path) == true:
			var nameNodePiece = get_node(path)
			if nameNodePiece.get_node("Timer").visible == true:
			#and nameNodePiece.spawnedTimerSpawnedThisTurn == false:
				if "White" in piece:
					if GlobalValueChessGame.turnWhite == false:
						nameNodePiece.timer -= 1
						nameNodePiece.get_node("Timer").text = str(nameNodePiece.timer)
				if "Black" in piece:
					if GlobalValueChessGame.turnWhite == true:
						nameNodePiece.timer -= 1
						nameNodePiece.get_node("Timer").text = str(nameNodePiece.timer)

func searchTimerOfPiece(arrayPieces, animationName):
		for piece in arrayPieces:
			var path = "/root/Game/ChessBoard/" + piece
			if has_node(path) == true:
				var nameNodePiece = get_node(path)
				if nameNodePiece.get_node("Timer").visible == true and nameNodePiece.spawnedTimerSpawnedThisTurn == false:
					timerFinish(piece,nameNodePiece,animationName)
				elif nameNodePiece.get_node("Timer").visible == true and nameNodePiece.spawnedTimerSpawnedThisTurn == true:
					nameNodePiece.spawnedTimerSpawnedThisTurn = false
			elif has_node(path) == false:
				continue

func timerFinish(piece,nameNodePiece,animationSelect):
	if nameNodePiece.timer == 0:
		if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
			GlobalValueChessGame.chessBoard[nameNodePiece.i][nameNodePiece.j] = "0"
			nameNodePiece.get_node("AnimationPowerOfGod").visible = true
			nameNodePiece.get_node("AnimationPowerOfGod").set_animation(animationSelect)
			nameNodePiece.get_node("AnimationPowerOfGod").scale = Vector2(2,2)
			nameNodePiece.get_node("AnimationPowerOfGod").play()
			GlobalValueChessGame.animationPlayed = true
		elif OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1:
			var coordonatesReverseI = reverseCoordonatesPieceI(nameNodePiece)
			var coordonatesReverseJ = reverseCoordonatesPieceJ(nameNodePiece)
			GlobalValueChessGame.chessBoard[coordonatesReverseI][coordonatesReverseJ] = "0"
			nameNodePiece.get_node("AnimationPowerOfGod").visible = true
			nameNodePiece.get_node("AnimationPowerOfGod").set_animation(animationSelect)
			nameNodePiece.get_node("AnimationPowerOfGod").scale = Vector2(2,2)
			nameNodePiece.get_node("AnimationPowerOfGod").play()
			GlobalValueChessGame.animationPlayed = true

##Power of Gods
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
			
	if GlobalValueMenu.godSelectPlayer2 == "GodOfDeath":
		if "PawnBlack" in pieceName:
			GodOfDeathPower.deathPowerPawn(playerID, chessBoard)
		elif "KnightBlack" in pieceName:
			GodOfDeathPower.deathPower(playerID,7)
		elif "BishopBlack" in pieceName:
			GodOfDeathPower.deathPower(playerID,9)
		elif "RookBlack" in pieceName:
			GodOfDeathPower.deathPower(playerID,11)
		elif "QueenBlack" in pieceName:
			GodOfDeathPower.deathPower(playerID,13)

func enablePowerOfDeathKing():
	if GlobalValueMenu.godSelectPlayer1 == "GodOfDeath":
		if GlobalValueChessGame.checkWhite == true:
			var playerIDKing = get_node("/root/Game/ChessBoard/KingBlack").playerID
			GodOfDeathPower.deathPowerKing(playerIDKing)
	if GlobalValueMenu.godSelectPlayer2 == "GodOfDeath":
		if GlobalValueChessGame.checkBlack == true:
			var playerIDKing = get_node("/root/Game/ChessBoard/KingWhite").playerID
			GodOfDeathPower.deathPowerKing(playerIDKing)

func deathPowerTimer():
	if GlobalValueMenu.godSelectPlayer2 == "GodOfDeath":
		searchTimerOfPiece(piecesWhiteWithoutKing, "PowerGodOfDeathPieceTimerFinish")

	if GlobalValueMenu.godSelectPlayer1 == "GodOfDeath":
		searchTimerOfPiece(piecesBlackWithoutKing, "PowerGodOfDeathPieceTimerFinish")

#Goddess of Teleportation
func enablePowerOfTeleportation(i, j,chessBoard,nameOfPiece,white,coordinateILastMove,coordinateJLastMove):
	if GlobalValueMenu.godSelectPlayer1 == "GoddessOfTeleportation" and white == true:
		GoddessOfTeleportation.teleportationPower(i, j,chessBoard,nameOfPiece,white,coordinateILastMove,coordinateJLastMove)
	if GlobalValueMenu.godSelectPlayer2 == "GoddessOfTeleportation" and white == false:
		GoddessOfTeleportation.teleportationPower(i, j,chessBoard,nameOfPiece,white,coordinateILastMove,coordinateJLastMove)

#God of the Secte
func enablePowerOfSect(chessBoard):
	if GlobalValueMenu.godSelectPlayer1 == "GodOfTheSect":
		GodOfTheSectPower.searchOpposingPieces(chessBoard)
	elif GlobalValueMenu.godSelectPlayer2 == "GodOfTheSect":
		pass

func sectPowerTimer():
	if GlobalValueMenu.godSelectPlayer2 == "GodOfTheSect":
		searchTimerOfPiece(piecesWhiteWithoutKing, "PowerGodOfTheSectConversion")
				
	if GlobalValueMenu.godSelectPlayer1 == "GodOfTheSect":
		searchTimerOfPiece(piecesBlackWithoutKing, "PowerGodOfTheSectConversion")


