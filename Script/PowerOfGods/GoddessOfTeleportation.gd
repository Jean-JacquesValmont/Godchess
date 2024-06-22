extends Node

var offsetKingI = 0
var offsetKingJ = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func conditionGameDirectionPlayer1(i, j,chessBoard,count,direction,positions,pawnColor,bishopColor,rookColor,queenColor,kingColor):
	if pawnColor in chessBoard[i-1][j] or bishopColor in chessBoard[i-1][j] or queenColor in chessBoard[i-1][j] or kingColor in chessBoard[i-1][j]:
		count += 1
		direction = "Haut"
	if rookColor in chessBoard[i-1][j+1] or queenColor in chessBoard[i-1][j+1] or kingColor in chessBoard[i-1][j+1]:
		count += 1
		direction = "Haut/Droite"
	if bishopColor in chessBoard[i][j+1] or queenColor in chessBoard[i][j+1] or kingColor in chessBoard[i][j+1]:
		count += 1
		direction = "Droite"
	if rookColor in chessBoard[i+1][j+1] or queenColor in chessBoard[i+1][j+1] or kingColor in chessBoard[i+1][j+1]:
		count += 1
		direction = "Bas/Droite"
	if bishopColor in chessBoard[i+1][j] or queenColor in chessBoard[i+1][j] or kingColor in chessBoard[i+1][j]:
		count += 1
		direction = "Bas"
	if rookColor in chessBoard[i+1][j-1] or queenColor in chessBoard[i+1][j-1] or kingColor in chessBoard[i+1][j-1]:
		count += 1
		direction = "Bas/Gauche"
	if bishopColor in chessBoard[i][j-1] or queenColor in chessBoard[i][j-1] or kingColor in chessBoard[i][j-1]:
		count += 1
		direction = "Gauche"
	if rookColor in chessBoard[i-1][j-1] or queenColor in chessBoard[i-1][j-1] or kingColor in chessBoard[i-1][j-1]:
		count += 1
		direction = "Haut/Gauche"
	for pos in positions:
		var x = i+pos.x
		var y = j+pos.y
		if x >= 0 and x < chessBoard.size() and y >= 0 and y < chessBoard[0].size():
			if "KingWhite" in chessBoard[i+pos.x][j+pos.y]:
				count += 1
				offsetKingI = pos.x
				offsetKingJ = pos.y
				direction = "Autre"
				
	return {"count": count, "direction": direction, "offsetKingI": offsetKingI, "offsetKingJ": offsetKingJ}

func conditionGameDirectionPlayer2(i, j,chessBoard,count,direction,positions,pawnColor,bishopColor,rookColor,queenColor,kingColor):
	if pawnColor in chessBoard[i+1][j] or bishopColor in chessBoard[i+1][j] or queenColor in chessBoard[i+1][j] or kingColor in chessBoard[i+1][j]:
		count += 1
		direction = "Bas"
	if rookColor in chessBoard[i+1][j-1] or queenColor in chessBoard[i+1][j-1] or kingColor in chessBoard[i+1][j-1]:
		count += 1
		direction = "Bas/Gauche"
	if bishopColor in chessBoard[i][j-1] or queenColor in chessBoard[i][j-1] or kingColor in chessBoard[i][j-1]:
		count += 1
		direction = "Gauche"
	if rookColor in chessBoard[i-1][j-1] or queenColor in chessBoard[i-1][j-1] or kingColor in chessBoard[i-1][j-1]:
		count += 1
		direction = "Haut/Gauche"
	if bishopColor in chessBoard[i-1][j] or queenColor in chessBoard[i-1][j] or kingColor in chessBoard[i-1][j]:
		count += 1
		direction = "Haut"
	if rookColor in chessBoard[i-1][j+1] or queenColor in chessBoard[i-1][j+1] or kingColor in chessBoard[i-1][j+1]:
		count += 1
		direction = "Haut/Droite"
	if bishopColor in chessBoard[i][j+1] or queenColor in chessBoard[i][j+1] or kingColor in chessBoard[i][j+1]:
		count += 1
		direction = "Droite"
	if rookColor in chessBoard[i+1][j+1] or queenColor in chessBoard[i+1][j+1] or kingColor in chessBoard[i+1][j+1]:
		count += 1
		direction = "Bas/Droite"
	for pos in positions:
		var x = i+pos.x
		var y = j+pos.y
		if x >= 0 and x < chessBoard.size() and y >= 0 and y < chessBoard[0].size():
			if "KingWhite" in chessBoard[i+pos.x][j+pos.y]:
				count += 1
				offsetKingI = pos.x
				offsetKingJ = pos.y
				direction = "Autre"
	
	return {"count": count, "direction": direction, "offsetKingI": offsetKingI, "offsetKingJ": offsetKingJ}

func countTeleportationZone(i, j,chessBoard,white):
	var positions = [
		Vector2(-2, 0), Vector2(-2, 1), Vector2(-1, 2), Vector2(0, 2),
		Vector2(1, 2), Vector2(2, 1), Vector2(2, 0), Vector2(2, -1),
		Vector2(1, -2), Vector2(0, -2), Vector2(-1, -2), Vector2(-2, -1),
		Vector2(-3, 0), Vector2(0, 3), Vector2(3, 0), Vector2(0, -3)
	]
	var count = 0
	var direction = ""
	var offsetKingI = 0
	var offsetKingJ = 0
	if white == true:
		if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
			var result = conditionGameDirectionPlayer1(i, j,chessBoard,count,direction,positions,"PawnWhite","BishopWhite","RookWhite","QueenWhite","KingWhite")
			count = result.count
			direction = result.direction
			offsetKingI = result.offsetKingI
			offsetKingJ = result.offsetKingJ
		elif OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1:
			var result = conditionGameDirectionPlayer2(i, j,chessBoard,count,direction,positions,"PawnWhite","BishopWhite","RookWhite","QueenWhite","KingWhite")
			count = result.count
			direction = result.direction
			offsetKingI = result.offsetKingI
			offsetKingJ = result.offsetKingJ
					
	return {"count": count, "direction": direction, "offsetKingI": offsetKingI, "offsetKingJ": offsetKingJ}

func animationPowerTeleportationDirection(i, j,chessBoard,nameOfPiece,directionFindPiece,offsetKingI,offsetKingJ):
	var directionMap = {
		"Haut": Vector2(-2, 0),
		"Bas": Vector2(2, 0),
		"Droite": Vector2(0, 2),
		"Gauche": Vector2(0, -2),
		"Haut/Droite": Vector2(-2, 2),
		"Haut/Gauche": Vector2(-2, -2),
		"Bas/Droite": Vector2(2, 2),
		"Bas/Gauche": Vector2(2, -2),
		"Autre": Vector2(offsetKingI*2, offsetKingJ*2)
	}
	var path = "/root/Game/ChessBoard/" + nameOfPiece
	get_node(path).teleportationDirection = directionFindPiece
	
	if "White" in nameOfPiece:
		var offset = directionMap[directionFindPiece]
		var newI = i + offset.x
		var newJ = j + offset.y
		if newI >= 0 and newI < chessBoard.size() and newJ >= 0 and newJ < chessBoard[0].size():
			if chessBoard[newI][newJ] == "0" or ("Black" in chessBoard[newI][newJ] and not "King" in chessBoard[newI][newJ]):
				print("Enter in animationPowerTeleportationDirection chessBoard == 0 or Black")
				var animation_node = get_node(path + "/AnimationPowerOfGod")
				animation_node.visible = true
				animation_node.set_animation("PowerGoddessOfTeleportationEffectInitial")
				animation_node.scale = Vector2(2, 2)
				animation_node.play()
				GlobalValueChessGame.animationPlayed = true

func teleportationPower(i, j,chessBoard,nameOfPiece,white,coordinateILastMove,coordinateJLastMove):
	var countZoneTeleportation = 0
	var directionFindPiece = ""
	
	print("Enter in teleportation power ", nameOfPiece)
	
	var result = countTeleportationZone(i, j, chessBoard,white)
	countZoneTeleportation = result.count
	directionFindPiece = result.direction
	offsetKingI = result.offsetKingI
	offsetKingJ = result.offsetKingJ
	
	if "KnightWhite" in chessBoard[i][j]:
		var moveKnight = ""
		var diffI = i-coordinateILastMove
		var diffJ = j-coordinateJLastMove
		print("diffI: ", diffI)
		print("diffJ: ", diffJ)
		if diffI == -2 and diffJ == 1:
			moveKnight = "Haut/Droite"
		elif diffI == -1 and diffJ == 2:
			moveKnight = "Droite/Haut"
		elif diffI == 1 and diffJ == 2:
			moveKnight = "Droite/Bas"
		elif diffI == 2 and diffJ == 1:
			moveKnight = "Bas/Droite"
		elif diffI == 2 and diffJ == -1:
			moveKnight = "Bas/Gauche"
		elif diffI == 1 and diffJ == -2:
			moveKnight = "Gauche/Bas"
		elif diffI == -1 and diffJ == -2:
			moveKnight = "Gauche/Haut"
		elif diffI == -2 and diffJ == -1:
			moveKnight = "Haut/Gauche"
	
		print("moveKnight: ", moveKnight)
		if moveKnight == "Haut/Gauche":
			print("chessBoard[i+1][j+1]: ", chessBoard[i+1][j+1])
			if "White" in chessBoard[i+1][j+1]:
				var path = "/root/Game/ChessBoard/" + chessBoard[i+1][j+1]
				get_node(path).teleportationDirection = "Haut/Gauche"
				if chessBoard[i-1][j-1] == "0" or ("Black" in chessBoard[i-1][j-1] and not "King" in chessBoard[i-1][j-1]):
					print("Enter in KnightWhite teleportation chessBoard == 0 or Black")
					var animation_node = get_node(path + "/AnimationPowerOfGod")
					animation_node.visible = true
					animation_node.set_animation("PowerGoddessOfTeleportationEffectInitial")
					animation_node.scale = Vector2(2, 2)
					animation_node.play()
					GlobalValueChessGame.animationPlayed = true
	
	if countZoneTeleportation == 0 or countZoneTeleportation > 1:
		return
	elif countZoneTeleportation == 1:
		animationPowerTeleportationDirection(i, j,chessBoard,nameOfPiece,directionFindPiece,offsetKingI,offsetKingJ)
