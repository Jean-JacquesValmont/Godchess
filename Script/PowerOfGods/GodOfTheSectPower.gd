extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

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
