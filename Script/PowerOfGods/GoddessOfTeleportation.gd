extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func countTeleportationZone(i, j,chessBoard,white):
	var count = 0
	var direction = ""
	if white == true:
		if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
			if "PawnWhite" in chessBoard[i-1][j] or "BishopWhite" in chessBoard[i-1][j] or "QueenWhite" in chessBoard[i-1][j] or "KingWhite" in chessBoard[i-1][j]:
				count += 1
				direction = "Haut"
			if "RookWhite" in chessBoard[i-1][j+1] or "QueenWhite" in chessBoard[i-1][j+1] or "KingWhite" in chessBoard[i-1][j+1]:
				count += 1
				direction = "Haut/Droite"
			if "BishopWhite" in chessBoard[i][j+1] or "QueenWhite" in chessBoard[i][j+1] or "KingWhite" in chessBoard[i][j+1]:
				count += 1
				direction = "Droite"
			if "RookWhite" in chessBoard[i+1][j+1] or "QueenWhite" in chessBoard[i+1][j+1] or "KingWhite" in chessBoard[i+1][j+1]:
				count += 1
				direction = "Bas/Droite"
			if "BishopWhite" in chessBoard[i+1][j] or "QueenWhite" in chessBoard[i+1][j] or "KingWhite" in chessBoard[i+1][j]:
				count += 1
				direction = "Bas"
			if "RookWhite" in chessBoard[i+1][j-1] or "QueenWhite" in chessBoard[i+1][j-1] or "KingWhite" in chessBoard[i+1][j-1]:
				count += 1
				direction = "Bas/Gauche"
			if "BishopWhite" in chessBoard[i][j-1] or "QueenWhite" in chessBoard[i][j-1] or "KingWhite" in chessBoard[i][j-1]:
				count += 1
				direction = "Gauche"
			if "RookWhite" in chessBoard[i-1][j-1] or "QueenWhite" in chessBoard[i-1][j-1] or "KingWhite" in chessBoard[i-1][j-1]:
				count += 1
				direction = "Haut/Gauche"
		elif OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1:
			if "PawnWhite" in chessBoard[i+1][j] or "BishopWhite" in chessBoard[i+1][j] or "QueenWhite" in chessBoard[i+1][j] or "KingWhite" in chessBoard[i+1][j]:
				count += 1
				direction = "Bas"
			if "RookWhite" in chessBoard[i+1][j-1] or "QueenWhite" in chessBoard[i+1][j-1] or "KingWhite" in chessBoard[i+1][j-1]:
				count += 1
				direction = "Bas/Gauche"
			if "BishopWhite" in chessBoard[i][j-1] or "QueenWhite" in chessBoard[i][j-1] or "KingWhite" in chessBoard[i][j-1]:
				count += 1
				direction = "Gauche"
			if "RookWhite" in chessBoard[i-1][j-1] or "QueenWhite" in chessBoard[i-1][j-1] or "KingWhite" in chessBoard[i-1][j-1]:
				count += 1
				direction = "Haut/Gauche"
			if "BishopWhite" in chessBoard[i-1][j] or "QueenWhite" in chessBoard[i-1][j] or "KingWhite" in chessBoard[i-1][j]:
				count += 1
				direction = "Haut"
			if "RookWhite" in chessBoard[i-1][j+1] or "QueenWhite" in chessBoard[i-1][j+1] or "KingWhite" in chessBoard[i-1][j+1]:
				count += 1
				direction = "Haut/Droite"
			if "BishopWhite" in chessBoard[i][j+1] or "QueenWhite" in chessBoard[i][j+1] or "KingWhite" in chessBoard[i][j+1]:
				count += 1
				direction = "Droite"
			if "RookWhite" in chessBoard[i+1][j+1] or "QueenWhite" in chessBoard[i+1][j+1] or "KingWhite" in chessBoard[i+1][j+1]:
				count += 1
				direction = "Bas/Droite"

	return {"count": count, "direction": direction}

func animationPowerTeleportationDirection(i, j,chessBoard,nameOfPiece,directionFindPiece):
	var directionMap = {
		"Haut": Vector2(-2, 0),
		"Bas": Vector2(2, 0),
		"Droite": Vector2(0, 2),
		"Gauche": Vector2(0, -2),
		"Haut/Droite": Vector2(-2, 2),
		"Haut/Gauche": Vector2(-2, -2),
		"Bas/Droite": Vector2(2, 2),
		"Bas/Gauche": Vector2(2, -2)
	}
	var path = "/root/Game/ChessBoard/" + nameOfPiece
	get_node(path).teleportationDirection = directionFindPiece
	
	if "White" in nameOfPiece:
		var offset = directionMap[directionFindPiece]
		var newI = i + offset.x
		var newJ = j + offset.y
		if chessBoard[newI][newJ] == "0" or ("Black" in chessBoard[newI][newJ] and not "King" in chessBoard[newI][newJ]):
			var animation_node = get_node(path + "/AnimationPowerOfGod")
			animation_node.visible = true
			animation_node.set_animation("PowerGoddessOfTeleportationEffectInitial")
			animation_node.scale = Vector2(2, 2)
			animation_node.play()
			GlobalValueChessGame.animationPlayed = true

func teleportationPower(i, j,chessBoard,nameOfPiece,white):
	var countZoneTeleportation = 0
	var directionFindPiece = ""
	print("Enter in teleportation power ", nameOfPiece)
	
	var result = countTeleportationZone(i, j, chessBoard,white)
	countZoneTeleportation = result.count
	directionFindPiece = result.direction
	
	if countZoneTeleportation == 0 or countZoneTeleportation > 1:
		return
	elif countZoneTeleportation == 1:
		animationPowerTeleportationDirection(i, j,chessBoard,nameOfPiece,directionFindPiece)
