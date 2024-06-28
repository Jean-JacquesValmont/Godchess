extends Node

var offsetKingFinalI = 0
var offsetKingFinalJ = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func getNamePieceAnimation(nameOfPiece):
	if "Pawn" in nameOfPiece:
		return "Pawn"
	elif "Knight" in nameOfPiece:
		return "Knight"
	elif "Bishop" in nameOfPiece:
		return "Bishop"
	elif "Rook" in nameOfPiece:
		return "Rook"
	elif "Queen" in nameOfPiece:
		return "Queen"
	elif "King" in nameOfPiece:
		return "King"

func searchMoveDirectionKnight(diffI,diffJ):
	if diffI == -2 and diffJ == 1:
		return "Haut/Droite"
	elif diffI == -1 and diffJ == 2:
		return "Droite/Haut"
	elif diffI == 1 and diffJ == 2:
		return "Droite/Bas"
	elif diffI == 2 and diffJ == 1:
		return "Bas/Droite"
	elif diffI == 2 and diffJ == -1:
		return "Bas/Gauche"
	elif diffI == 1 and diffJ == -2:
		return "Gauche/Bas"
	elif diffI == -1 and diffJ == -2:
		return "Gauche/Haut"
	elif diffI == -2 and diffJ == -1:
		return "Haut/Gauche"

func conditionGameDirectionPlayer1(i, j,chessBoard,count,direction,positions,pawnColor,bishopColor,rookColor,queenColor,kingColor):
	var offsetKingI = 0
	var offsetKingJ = 0
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
			if kingColor in chessBoard[i+pos.x][j+pos.y]:
				count += 1
				offsetKingI = pos.x
				offsetKingJ = pos.y
				direction = "Autre"
				
	return {"count": count, "direction": direction, "offsetKingI": offsetKingI, "offsetKingJ": offsetKingJ}

func conditionGameDirectionPlayer2(i, j,chessBoard,count,direction,positions,pawnColor,bishopColor,rookColor,queenColor,kingColor):
	var offsetKingI = 0
	var offsetKingJ = 0
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
			if kingColor in chessBoard[i+pos.x][j+pos.y]:
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
	elif white == false:
		if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
			var result = conditionGameDirectionPlayer2(i, j,chessBoard,count,direction,positions,"PawnBlack","BishopBlack","RookBlack","QueenBlack","KingBlack")
			count = result.count
			direction = result.direction
			offsetKingI = result.offsetKingI
			offsetKingJ = result.offsetKingJ
		elif OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1:
			var result = conditionGameDirectionPlayer1(i, j,chessBoard,count,direction,positions,"PawnBlack","BishopBlack","RookBlack","QueenBlack","KingBlack")
			count = result.count
			direction = result.direction
			offsetKingI = result.offsetKingI
			offsetKingJ = result.offsetKingJ
					
	return {"count": count, "direction": direction, "offsetKingI": offsetKingI, "offsetKingJ": offsetKingJ}

func animationPowerTeleportationDirectionKnight(i,j,chessBoard,offset1,offset2,countZoneTeleportationPiece,directionTP,namePieceAnimation):
	if "White" in chessBoard[i+offset1.x][j+offset1.y] and countZoneTeleportationPiece == 0:
		var path = "/root/Game/ChessBoard/" + chessBoard[i+offset1.x][j+offset1.y]
		get_node(path).teleportationDirection = directionTP
		namePieceAnimation = getNamePieceAnimation(chessBoard[i+offset1.x][j+offset1.y])
		if chessBoard[i+offset2.x][j+offset2.y] == "0" or ("Black" in chessBoard[i+offset2.x][j+offset2.y] and not "King" in chessBoard[i+offset2.x][j+offset2.y]):
			var animation_node = get_node(path + "/AnimationPowerOfGod")
			animation_node.visible = true
			animation_node.set_animation("PowerGoddessOfTeleportationEffectInitial" + namePieceAnimation)
			animation_node.scale = Vector2(2, 2)
			get_node(path).self_modulate.a = 0
			animation_node.play()
			GlobalValueChessGame.animationPlayed = true
	elif "Black" in chessBoard[i+offset1.x][j+offset1.y] and countZoneTeleportationPiece == 0:
		var path = "/root/Game/ChessBoard/" + chessBoard[i+offset1.x][j+offset1.y]
		get_node(path).teleportationDirection = directionTP
		namePieceAnimation = getNamePieceAnimation(chessBoard[i+offset1.x][j+offset1.y])
		if chessBoard[i+offset2.x][j+offset2.y] == "0" or ("White" in chessBoard[i+offset2.x][j+offset2.y] and not "King" in chessBoard[i+offset2.x][j+offset2.y]):
			var animation_node = get_node(path + "/AnimationPowerOfGod")
			animation_node.visible = true
			animation_node.set_animation("PowerGoddessOfTeleportationEffectInitial" + namePieceAnimation)
			animation_node.scale = Vector2(2, 2)
			get_node(path).self_modulate.a = 0
			animation_node.play()
			GlobalValueChessGame.animationPlayed = true

func teleportationPowerKnight(i, j,chessBoard,nameOfPiece,white,coordinateILastMove,coordinateJLastMove):
	var directionMapKnightOffset = {
		"Haut/Droite": [Vector2(1, -1),Vector2(-1, 1),Vector2(0, -1),Vector2(0, 1)],
		"Droite/Haut": [Vector2(1, -1),Vector2(-1, 1),Vector2(1, 0),Vector2(-1, 0)],
		"Droite/Bas": [Vector2(-1, -1),Vector2(1, 1),Vector2(-1, 0),Vector2(1, 0)],
		"Bas/Droite": [Vector2(-1, -1),Vector2(1, 1),Vector2(0, -1),Vector2(0, 1)],
		"Bas/Gauche": [Vector2(-1, 1),Vector2(1, -1),Vector2(0, 1),Vector2(0, -1)],
		"Gauche/Bas": [Vector2(-1, 1),Vector2(1, -1),Vector2(-1, 0),Vector2(1, 0)],
		"Gauche/Haut": [Vector2(1, 1),Vector2(-1, -1),Vector2(1, 0),Vector2(-1, 0)],
		"Haut/Gauche": [Vector2(1, 1),Vector2(-1, -1),Vector2(0, 1),Vector2(0, -1)]
	}
	var directionMapKnightDirectionTP = {
		"Haut/Droite": ["Haut/Droite","Droite"],
		"Droite/Haut": ["Haut/Droite","Haut"],
		"Droite/Bas": ["Bas/Droite","Bas"],
		"Bas/Droite": ["Bas/Droite","Droite"],
		"Bas/Gauche": ["Bas/Gauche","Gauche"],
		"Gauche/Bas": ["Bas/Gauche","Bas"],
		"Gauche/Haut": ["Haut/Gauche","Haut"],
		"Haut/Gauche": ["Haut/Gauche","Gauche"]
	}
	var moveKnight = ""
	
	if "KnightWhite" in chessBoard[i][j]:
		var diffI = i-coordinateILastMove
		var diffJ = j-coordinateJLastMove
		
		moveKnight = searchMoveDirectionKnight(diffI,diffJ)
		
		var offset = directionMapKnightOffset[moveKnight]
		var directionTP = directionMapKnightDirectionTP[moveKnight]
		var result1 = countTeleportationZone(i+offset[0].x, j+offset[0].y,chessBoard,white)
		var result2 = countTeleportationZone(i+offset[2].x, j+offset[2].y,chessBoard,white)
		var countZoneTeleportationPiece1 = result1.count
		var countZoneTeleportationPiece2 = result2.count
		var namePiece1Animation = ""
		var namePiece2Animation = ""
		
		animationPowerTeleportationDirectionKnight(i,j,chessBoard,offset[0],offset[1],countZoneTeleportationPiece1,directionTP[0],namePiece1Animation)
		animationPowerTeleportationDirectionKnight(i,j,chessBoard,offset[2],offset[3],countZoneTeleportationPiece2,directionTP[1],namePiece2Animation)
		
	elif "KnightBlack" in chessBoard[i][j]:
		var diffI = i-coordinateILastMove
		var diffJ = j-coordinateJLastMove
		
		moveKnight = searchMoveDirectionKnight(diffI,diffJ)
		
		var offset = directionMapKnightOffset[moveKnight]
		var directionTP = directionMapKnightDirectionTP[moveKnight]
		var result1 = countTeleportationZone(i+offset[0].x, j+offset[0].y,chessBoard,white)
		var result2 = countTeleportationZone(i+offset[2].x, j+offset[2].y,chessBoard,white)
		var countZoneTeleportationPiece1 = result1.count
		var countZoneTeleportationPiece2 = result2.count
		var namePiece1Animation = ""
		var namePiece2Animation = ""
		
		animationPowerTeleportationDirectionKnight(i,j,chessBoard,offset[0],offset[1],countZoneTeleportationPiece1,directionTP[0],namePiece1Animation)
		animationPowerTeleportationDirectionKnight(i,j,chessBoard,offset[2],offset[3],countZoneTeleportationPiece2,directionTP[1],namePiece2Animation)

func animationPowerTeleportationDirection(i, j,chessBoard,nameOfPiece,directionFindPiece,offsetKingFinalI,offsetKingFinalJ):
	var directionMap = {
		"Haut": Vector2(-2, 0),
		"Bas": Vector2(2, 0),
		"Droite": Vector2(0, 2),
		"Gauche": Vector2(0, -2),
		"Haut/Droite": Vector2(-2, 2),
		"Haut/Gauche": Vector2(-2, -2),
		"Bas/Droite": Vector2(2, 2),
		"Bas/Gauche": Vector2(2, -2),
		"Autre": Vector2(offsetKingFinalI*2, offsetKingFinalJ*2)
	}
	var path = "/root/Game/ChessBoard/" + nameOfPiece
	var namePieceAnimation = ""
	get_node(path).teleportationDirection = directionFindPiece
	
	namePieceAnimation = getNamePieceAnimation(nameOfPiece)
	
	if "White" in nameOfPiece:
		var offset = directionMap[directionFindPiece]
		var newI = i + offset.x
		var newJ = j + offset.y
		if newI >= 0 and newI < chessBoard.size() and newJ >= 0 and newJ < chessBoard[0].size():
			if chessBoard[newI][newJ] == "0" or ("Black" in chessBoard[newI][newJ] and not "King" in chessBoard[newI][newJ]):
				var animation_node = get_node(path + "/AnimationPowerOfGod")
				animation_node.visible = true
				animation_node.set_animation("PowerGoddessOfTeleportationEffectInitial" + namePieceAnimation)
				animation_node.scale = Vector2(2, 2)
				get_node(path).self_modulate.a = 0
				animation_node.play()
				GlobalValueChessGame.animationPlayed = true
	elif "Black" in nameOfPiece:
		var offset = directionMap[directionFindPiece]
		var newI = i + offset.x
		var newJ = j + offset.y
		if newI >= 0 and newI < chessBoard.size() and newJ >= 0 and newJ < chessBoard[0].size():
			if chessBoard[newI][newJ] == "0" or ("White" in chessBoard[newI][newJ] and not "King" in chessBoard[newI][newJ]):
				var animation_node = get_node(path + "/AnimationPowerOfGod")
				animation_node.visible = true
				animation_node.set_animation("PowerGoddessOfTeleportationEffectInitial" + namePieceAnimation)
				animation_node.scale = Vector2(2, 2)
				get_node(path).self_modulate.a = 0
				animation_node.play()
				GlobalValueChessGame.animationPlayed = true

func teleportationPower(i, j,chessBoard,nameOfPiece,white,coordinateILastMove,coordinateJLastMove):
	var countZoneTeleportation = 0
	var directionFindPiece = ""
	
	var result = countTeleportationZone(i, j, chessBoard, white)
	countZoneTeleportation = result.count
	directionFindPiece = result.direction
	offsetKingFinalI = result.offsetKingI
	offsetKingFinalJ = result.offsetKingJ
	
	teleportationPowerKnight(i, j,chessBoard,nameOfPiece,white,coordinateILastMove,coordinateJLastMove)
	
	if countZoneTeleportation == 1:
		animationPowerTeleportationDirection(i, j,chessBoard,nameOfPiece,directionFindPiece,offsetKingFinalI,offsetKingFinalJ)
