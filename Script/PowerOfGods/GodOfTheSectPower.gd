extends Node

var usePowerKing = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func decreaseTimerByNumberOfSectPieces(nameNodePiece,chessBoard,chessBoardReverse):
	print("Enter in decreaseTimerByNumberOfSectPieces")
	print("OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id: ", OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id)
	var totalPieces = 0
	var i = nameNodePiece.i
	var j = nameNodePiece.j
	print("i: ", i)
	print("j: ", j)
	if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
		if chessBoard[i + 1][j].begins_with("PawnWhite"):
			totalPieces += 1
		if chessBoard[i - 2][j - 1].begins_with("KnightWhite") or chessBoard[i - 2][j + 1].begins_with("KnightWhite")\
		or chessBoard[i - 1][j + 2].begins_with("KnightWhite") or chessBoard[i + 1][j + 2].begins_with("KnightWhite")\
		or chessBoard[i + 2][j - 1].begins_with("KnightWhite") or chessBoard[i + 2][j + 1].begins_with("KnightWhite")\
		or chessBoard[i - 1][j - 2].begins_with("KnightWhite") or chessBoard[i + 1][j - 2].begins_with("KnightWhite"):
			totalPieces += 1
		if chessBoard[i - 1][j + 1].begins_with("BishopWhite") or chessBoard[i + 1][j + 1].begins_with("BishopWhite")\
		or chessBoard[i + 1][j - 1].begins_with("BishopWhite") or chessBoard[i - 1][j - 1].begins_with("BishopWhite"):
			totalPieces += 1
		if chessBoard[i - 1][j].begins_with("RookWhite") or chessBoard[i][j + 1].begins_with("RookWhite")\
		or chessBoard[i + 1][j].begins_with("RookWhite") or chessBoard[i][j - 1].begins_with("RookWhite"):
			totalPieces += 1
		if chessBoard[i - 1][j].begins_with("QueenWhite") or chessBoard[i][j + 1].begins_with("QueenWhite")\
		or chessBoard[i + 1][j].begins_with("QueenWhite") or chessBoard[i][j - 1].begins_with("QueenWhite")\
		or chessBoard[i - 1][j + 1].begins_with("QueenWhite") or chessBoard[i + 1][j + 1].begins_with("QueenWhite")\
		or chessBoard[i + 1][j - 1].begins_with("QueenWhite") or chessBoard[i - 1][j - 1].begins_with("QueenWhite"):
			totalPieces += 1
	elif OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1:
		if chessBoardReverse[i - 1][j].begins_with("PawnWhite"):
			totalPieces += 1
		if chessBoardReverse[i - 2][j - 1].begins_with("KnightWhite") or chessBoardReverse[i - 2][j + 1].begins_with("KnightWhite")\
		or chessBoardReverse[i - 1][j + 2].begins_with("KnightWhite") or chessBoardReverse[i + 1][j + 2].begins_with("KnightWhite")\
		or chessBoardReverse[i + 2][j - 1].begins_with("KnightWhite") or chessBoardReverse[i + 2][j + 1].begins_with("KnightWhite")\
		or chessBoardReverse[i - 1][j - 2].begins_with("KnightWhite") or chessBoardReverse[i + 1][j - 2].begins_with("KnightWhite"):
			totalPieces += 1
		if chessBoardReverse[i - 1][j + 1].begins_with("BishopWhite") or chessBoardReverse[i + 1][j + 1].begins_with("BishopWhite")\
		or chessBoardReverse[i + 1][j - 1].begins_with("BishopWhite") or chessBoardReverse[i - 1][j - 1].begins_with("BishopWhite"):
			totalPieces += 1
		if chessBoardReverse[i - 1][j].begins_with("RookWhite") or chessBoardReverse[i][j + 1].begins_with("RookWhite")\
		or chessBoardReverse[i + 1][j].begins_with("RookWhite") or chessBoardReverse[i][j - 1].begins_with("RookWhite"):
			totalPieces += 1
		if chessBoardReverse[i - 1][j].begins_with("QueenWhite") or chessBoardReverse[i][j + 1].begins_with("QueenWhite")\
		or chessBoardReverse[i + 1][j].begins_with("QueenWhite") or chessBoardReverse[i][j - 1].begins_with("QueenWhite")\
		or chessBoardReverse[i - 1][j + 1].begins_with("QueenWhite") or chessBoardReverse[i + 1][j + 1].begins_with("QueenWhite")\
		or chessBoardReverse[i + 1][j - 1].begins_with("QueenWhite") or chessBoardReverse[i - 1][j - 1].begins_with("QueenWhite"):
			totalPieces += 1
			
	print("totalPieces: ", totalPieces)
	nameNodePiece.timer -= totalPieces
	if nameNodePiece.timer < 0:
		nameNodePiece.timer = 0
	nameNodePiece.get_node("Timer").text = str(nameNodePiece.timer)

func searchOpposingPieces(chessBoard):
	for i in range(2,10): 
		for j in range(2,10):
			if chessBoard[i][j].begins_with("PawnBlack") or chessBoard[i][j].begins_with("KnightBlack")\
			or chessBoard[i][j].begins_with("BishopBlack") or chessBoard[i][j].begins_with("RookBlack")\
			or chessBoard[i][j].begins_with("QueenBlack"):
				var pieceName = chessBoard[i][j]
				searchSectPieces(i,j,chessBoard,pieceName)

func searchSectPieces(i,j,chessBoard,pieceName):
	var path = "/root/Game/ChessBoard/" + pieceName
	if chessBoard[i + 1][j].begins_with("PawnWhite"):
		if get_node(path + "/Timer").visible == false:
			get_node(path + "/AnimationPowerOfGod").visible = true
			get_node(path + "/AnimationPowerOfGod").set_animation("PowerGodOfTheSectMentalInfluence")
			get_node(path + "/AnimationPowerOfGod").scale = Vector2(2,2)
			get_node(path + "/AnimationPowerOfGod").play()
			GlobalValueChessGame.animationPlayed = true
	elif chessBoard[i - 2][j - 1].begins_with("KnightWhite") or chessBoard[i - 2][j + 1].begins_with("KnightWhite")\
	or chessBoard[i - 1][j + 2].begins_with("KnightWhite") or chessBoard[i + 1][j + 2].begins_with("KnightWhite")\
	or chessBoard[i + 2][j - 1].begins_with("KnightWhite") or chessBoard[i + 2][j + 1].begins_with("KnightWhite")\
	or chessBoard[i - 1][j - 2].begins_with("KnightWhite") or chessBoard[i + 1][j - 2].begins_with("KnightWhite"):
		if get_node(path + "/Timer").visible == false:
			get_node(path + "/AnimationPowerOfGod").visible = true
			get_node(path + "/AnimationPowerOfGod").set_animation("PowerGodOfTheSectMentalInfluence")
			get_node(path + "/AnimationPowerOfGod").scale = Vector2(2,2)
			get_node(path + "/AnimationPowerOfGod").play()
			GlobalValueChessGame.animationPlayed = true
	elif chessBoard[i - 1][j + 1].begins_with("BishopWhite") or chessBoard[i + 1][j + 1].begins_with("BishopWhite")\
	or chessBoard[i + 1][j - 1].begins_with("BishopWhite") or chessBoard[i - 1][j - 1].begins_with("BishopWhite"):
		if get_node(path + "/Timer").visible == false:
			get_node(path + "/AnimationPowerOfGod").visible = true
			get_node(path + "/AnimationPowerOfGod").set_animation("PowerGodOfTheSectMentalInfluence")
			get_node(path + "/AnimationPowerOfGod").scale = Vector2(2,2)
			get_node(path + "/AnimationPowerOfGod").play()
			GlobalValueChessGame.animationPlayed = true
	elif chessBoard[i - 1][j].begins_with("RookWhite") or chessBoard[i][j + 1].begins_with("RookWhite")\
	or chessBoard[i + 1][j].begins_with("RookWhite") or chessBoard[i][j - 1].begins_with("RookWhite"):
		if get_node(path + "/Timer").visible == false:
			get_node(path + "/AnimationPowerOfGod").visible = true
			get_node(path + "/AnimationPowerOfGod").set_animation("PowerGodOfTheSectMentalInfluence")
			get_node(path + "/AnimationPowerOfGod").scale = Vector2(2,2)
			get_node(path + "/AnimationPowerOfGod").play()
			GlobalValueChessGame.animationPlayed = true
	elif chessBoard[i - 1][j].begins_with("QueenWhite") or chessBoard[i][j + 1].begins_with("QueenWhite")\
	or chessBoard[i + 1][j].begins_with("QueenWhite") or chessBoard[i][j - 1].begins_with("QueenWhite")\
	or chessBoard[i - 1][j + 1].begins_with("QueenWhite") or chessBoard[i + 1][j + 1].begins_with("QueenWhite")\
	or chessBoard[i + 1][j - 1].begins_with("QueenWhite") or chessBoard[i - 1][j - 1].begins_with("QueenWhite"):
		if get_node(path + "/Timer").visible == false:
			get_node(path + "/AnimationPowerOfGod").visible = true
			get_node(path + "/AnimationPowerOfGod").set_animation("PowerGodOfTheSectMentalInfluence")
			get_node(path + "/AnimationPowerOfGod").scale = Vector2(2,2)
			get_node(path + "/AnimationPowerOfGod").play()
			GlobalValueChessGame.animationPlayed = true
	else:
		if get_node(path + "/Timer").visible == true:
			get_node(path + "/Timer").visible = false
			get_node(path).timer = -1
			get_node(path + "/Timer").text = ""

func sectPowerKing(chessBoard,IKing,JKing):
	if usePowerKing == 1:
		for i in range(-2,3):
			for j in range(-2,3):
				if "Black" in chessBoard[i + IKing][j + JKing]:
					if i + IKing == GlobalValueChessGame.attackerPositioni and j + JKing == GlobalValueChessGame.attackerPositionj:
						var pieceName = chessBoard[i + IKing][j + JKing]
						var path = "/root/Game/ChessBoard/" + pieceName
						get_node(path + "/AnimationPowerOfGod").visible = true
						get_node(path + "/AnimationPowerOfGod").set_animation("PowerGodOfTheSectConversion")
						get_node(path + "/AnimationPowerOfGod").scale = Vector2(2,2)
						get_node(path + "/AnimationPowerOfGod").play()
						GlobalValueChessGame.animationPlayed = true
						usePowerKing -= 1
						break
