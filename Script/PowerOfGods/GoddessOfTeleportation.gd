extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func teleportationPower(i, j,chessBoard,nameOfPiece):
	var countZoneTeleportation = 0
	var directionFindPiece = ""
	var path = "/root/Game/ChessBoard/" + nameOfPiece
	print("Enter in teleportation power ", nameOfPiece)
	
	if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
		if "Pawn" in chessBoard[i-1][j] or "Bishop" in chessBoard[i-1][j] or "Queen" in chessBoard[i-1][j] or "King" in chessBoard[i-1][j]:
			print("Enter in teleportation power directionFindPiece = Haut")
			countZoneTeleportation += 1
			directionFindPiece = "Haut"
	elif OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1:
		if "Pawn" in chessBoard[i+1][j] or "Bishop" in chessBoard[i+1][j] or "Queen" in chessBoard[i-1][j] or "King" in chessBoard[i+1][j]:
			print("Enter in teleportation power directionFindPiece = Bas")
			countZoneTeleportation += 1
			directionFindPiece = "Bas"
	if "Rook" in chessBoard[i-1][j+1] or "Queen" in chessBoard[i-1][j+1] or "King" in chessBoard[i-1][j+1]:
		countZoneTeleportation += 1
		directionFindPiece = "Haut/Droite"
	if "Bishop" in chessBoard[i][j+1] or "Queen" in chessBoard[i][j+1] or "King" in chessBoard[i][j+1]:
		countZoneTeleportation += 1
		directionFindPiece = "Droite"
	if "Rook" in chessBoard[i+1][j+1] or "Queen" in chessBoard[i+1][j+1] or "King" in chessBoard[i+1][j+1]:
		countZoneTeleportation += 1
		directionFindPiece = "Bas/Droite"
	if "Bishop" in chessBoard[i+1][j] or "Queen" in chessBoard[i+1][j] or "King" in chessBoard[i+1][j]:
		countZoneTeleportation += 1
		directionFindPiece = "Bas"
	if "Rook" in chessBoard[i+1][j-1] or "Queen" in chessBoard[i+1][j-1] or "King" in chessBoard[i+1][j-1]:
		countZoneTeleportation += 1
		directionFindPiece = "Bas/Gauche"
	if "Bishop" in chessBoard[i][j-1] or "Queen" in chessBoard[i][j-1] or "King" in chessBoard[i][j-1]:
		countZoneTeleportation += 1
		directionFindPiece = "Gauche"
	if "Rook" in chessBoard[i-1][j-1] or "Queen" in chessBoard[i-1][j-1] or "King" in chessBoard[i-1][j-1]:
		countZoneTeleportation += 1
		directionFindPiece = "Haut/Gauche"
	
	if countZoneTeleportation == 0 or countZoneTeleportation > 1:
		return
	elif countZoneTeleportation == 1:
		print("Enter in teleportation power countZoneTeleportation == 1")
		if "White" in nameOfPiece:
			print("Enter in teleportation power White in nameOfPiece")
			if directionFindPiece == "Haut":
				if chessBoard[i-2][j] == "0" or ("Black" in chessBoard[i-2][j] and not "King" in chessBoard[i-2][j]):
					get_node(path + "/AnimationPowerOfGod").visible = true
					get_node(path + "/AnimationPowerOfGod").set_animation("PowerGoddessOfTeleportationEffectInitial")
					#get_node(path + "/AnimationPowerOfGod").scale = Vector2(2,2)
					get_node(path + "/AnimationPowerOfGod").play()
			elif directionFindPiece == "Bas":
				if chessBoard[i+2][j] == "0" or ("Black" in chessBoard[i+2][j] and not "King" in chessBoard[i+2][j]):
					get_node(path + "/AnimationPowerOfGod").visible = true
					get_node(path + "/AnimationPowerOfGod").set_animation("PowerGoddessOfTeleportationEffectInitial")
					#get_node(path + "/AnimationPowerOfGod").scale = Vector2(2,2)
					get_node(path + "/AnimationPowerOfGod").play()
			elif directionFindPiece == "Droite":
				pass
			elif directionFindPiece == "Gauche":
				pass
			elif directionFindPiece == "Haut/Droite":
				pass
			elif directionFindPiece == "Haut/Gauche":
				pass
			elif directionFindPiece == "Bas/Droite":
				pass
			elif directionFindPiece == "Bas/Gauche":
				pass
