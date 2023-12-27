extends Sprite2D

var dragging = false
var clickRadius = 50
var dragOffset = Vector2()
var moveCase = GlobalValueChessGame.oneMoveCase
var chessBoard = GlobalValueChessGame.chessBoard
var i = 9
var j = 5
var positionChessBoard
var Position = Vector2(350, 750)
@onready var nameOfPiece = get_name()
var initialPosition = true
var white = true
var textureWhite = preload("res://Image/Pieces/White/queen_white.png")
var textureBlack = preload("res://Image/Pieces/Black/queen_black.png")
var maxMoveUp = 1
var maxMoveDown = 1
var maxMoveLeft = 1
var maxMoveRight = 1
var maxMoveDownRight = 1
var maxMoveDownLeft = 1
var maxMoveUpLeft = 1
var maxMoveUpRight = 1
var pieceProtectsAgainstAnAttack = false
var directionAttackProtectKing = ""
var promoteInProgress = false
var pieceProtectTheKing = false
var attackerPositionshiftI = 0
var attackerPositionshiftJ = 0
var attackerPositionshift2I = 0
var attackerPositionshift2J = 0
var attackerPositionshift3I = 0
var attackerPositionshift3J = 0
var playerID

func _ready():
	await get_tree().process_frame
	positionChessBoard = get_parent().global_position
	if GlobalValueChessGame.startWhite == true:
		playWhite()
	elif GlobalValueChessGame.startWhite == false:
		playBlack()

	if white == true and OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
		playerID = OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id
	elif white == false and OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1:
		playerID = OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id

func _process(delta):
	pass

func _input(event):
	if playerID == OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT\
		and promoteInProgress == false and GlobalValueChessGame.checkmate == false and GlobalValueChessGame.stalemate == false:
			if (event.position - self.position - positionChessBoard).length() < clickRadius:
				# Start dragging if the click is on the sprite.
				if not dragging and event.pressed:
					dragging = true
					dragOffset = event.position - self.position - positionChessBoard
					z_index = 10
					checkMaxAllMove()
					theKingIsBehind()
					previewAllMove()
					print("GlobalValueChessGame.checkWhite: ", GlobalValueChessGame.checkWhite)
					print("GlobalValueChessGame.checkBlack: ", GlobalValueChessGame.checkBlack)
					print("pieceProtectTheKing: ", pieceProtectTheKing)
					print("attackerPositionshiftI: ", attackerPositionshiftI)
					print("attackerPositionshiftJ: ", attackerPositionshiftJ)
					print("attackerPositionshift2I: ", attackerPositionshift2I)
					print("attackerPositionshift2J: ", attackerPositionshift2J)
					print("attackerPositionshift2I: ", attackerPositionshift3I)
					print("attackerPositionshift2J: ", attackerPositionshift3J)
			# Stop dragging if the button is released.
			if dragging and not event.pressed:
				deleteAllChildMovePreview()
				get_node("Area2D/CollisionShape2D").disabled = false
				if white == true and GlobalValueChessGame.turnWhite == true:
					moveFinal(GlobalValueChessGame.checkWhite)
				elif white == false and GlobalValueChessGame.turnWhite == false:
					moveFinal(GlobalValueChessGame.checkBlack)
				self.position = Vector2(Position.x, Position.y)
				dragging = false
				z_index = 0
				for f in range(0,12):
					print(chessBoard[f])
					
		if event is InputEventMouseMotion and dragging:
			# While dragging, move the sprite with the mouse.
			self.position = event.position - positionChessBoard
			get_node("Area2D/CollisionShape2D").disabled = true
		
func move(dx, dy, maxMove) :
	for f in range (1,maxMove):
		var targetCaseX = dx*(f*moveCase)
		var targetCaseY = dy*(f*moveCase)
		var newTargetCaseX = targetCaseX + positionChessBoard.x
		var newTargetCaseY = targetCaseY + positionChessBoard.y
		if global_position.x >= (Position.x - 50) + newTargetCaseX  and global_position.x <= (Position.x + 50) + newTargetCaseX \
		and global_position.y >= (Position.y - 50) + newTargetCaseY and global_position.y <= (Position.y + 50) + newTargetCaseY \
		and ((chessBoard[i+(dy*f)][j+(dx*f)] == "0" or "Black" in chessBoard[i+(dy*f)][j+(dx*f)]) and GlobalValueChessGame.turnWhite == true\
		or (chessBoard[i+(dy*f)][j+(dx*f)] == "0" or "White" in chessBoard[i+(dy*f)][j+(dx*f)]) and GlobalValueChessGame.turnWhite == false):
			rpc("movePiece",f,targetCaseX,targetCaseY,dx,dy)
			break
		elif global_position.x >= get_parent().texture.get_width() + positionChessBoard.x\
		 or global_position.y >= get_parent().texture.get_height() + positionChessBoard.y :
			self.position = Vector2(Position.x, Position.y)

@rpc("any_peer", "call_local") func movePiece(f,targetCaseX,targetCaseY,dx,dy):
	self.position = Vector2((Position.x + targetCaseX), (Position.y + targetCaseY))
	Position = Vector2(self.position.x, self.position.y)
	chessBoard[i][j] = "0"
	i=i+(dy*f)
	j=j+(dx*f)
	chessBoard[i][j] = nameOfPiece.replace("@", "")
	initialPosition = false
	GlobalValueChessGame.turnWhite = !GlobalValueChessGame.turnWhite
	get_node("SoundMovePiece").play()
	resetLastMovePlay()
	lastMovePlay()

func defenceMove(attacki,attackj):
	print("Enter in defenceMove")
	var targetCaseX = (attackj - j) * moveCase
	var targetCaseY = (attacki - i) * moveCase
	var newTargetCaseX = targetCaseX + positionChessBoard.x
	var newTargetCaseY = targetCaseY + positionChessBoard.y
	if global_position.x >= (Position.x - 50) + newTargetCaseX  and global_position.x <= (Position.x + 50) + newTargetCaseX \
	and global_position.y >= (Position.y - 50) + newTargetCaseY and global_position.y <= (Position.y + 50) + newTargetCaseY \
	and ((chessBoard[attacki][attackj] == "0" or "Black" in chessBoard[attacki][attackj]) and GlobalValueChessGame.turnWhite == true\
	or (chessBoard[attacki][attackj] == "0" or "White" in chessBoard[attacki][attackj]) and GlobalValueChessGame.turnWhite == false):
		rpc("moveDefencePiece",targetCaseX,targetCaseY,attacki,attackj)
	elif global_position.x >= get_parent().texture.get_width() + positionChessBoard.x\
		 or global_position.y >= get_parent().texture.get_height() + positionChessBoard.y :
		self.position = Vector2(Position.x, Position.y)

@rpc("any_peer", "call_local") func moveDefencePiece(targetCaseX,targetCaseY,attacki,attackj):
	self.position = Vector2((Position.x + targetCaseX), (Position.y + targetCaseY))
	Position = Vector2(self.position.x, self.position.y)
	chessBoard[i][j] = "0"
	i=attacki
	j=attackj
	chessBoard[i][j] = nameOfPiece.replace("@", "")
	GlobalValueChessGame.turnWhite = !GlobalValueChessGame.turnWhite
	initialPosition = false
	attackerPositionshiftI = 0
	attackerPositionshiftJ = 0
	attackerPositionshift2I = 0
	attackerPositionshift2J = 0
	attackerPositionshift3I = 0
	attackerPositionshift3J = 0
	pieceProtectTheKing = false
	get_node("SoundMovePiece").play()
	resetLastMovePlay()
	lastMovePlay()

func moveWithPin():
	if pieceProtectsAgainstAnAttack == false:
		move(1,0, maxMoveRight)
		move(0,1, maxMoveDown)
		move(-1,0, maxMoveLeft)
		move(0,-1, maxMoveUp)
		move(1,1, maxMoveDownRight)
		move(1,-1, maxMoveUpRight)
		move(-1,1, maxMoveDownLeft)
		move(-1,-1, maxMoveUpLeft)
	elif pieceProtectsAgainstAnAttack == true:
		if directionAttackProtectKing == "Haut" or directionAttackProtectKing == "Bas":
			move(0,-1, maxMoveUp)
			move(0,1, maxMoveDown)
		elif directionAttackProtectKing == "Droite" or directionAttackProtectKing == "Gauche":
			move(1,0, maxMoveRight)
			move(-1,0, maxMoveLeft)
		elif directionAttackProtectKing == "Haut/Droite" or directionAttackProtectKing == "Bas/Gauche":
			move(1,-1, maxMoveUpRight)
			move(-1,1, maxMoveDownLeft)
		elif directionAttackProtectKing == "Haut/Gauche" or directionAttackProtectKing == "Bas/Droite":
			move(-1,-1, maxMoveUpLeft)
			move(1,1, maxMoveDownRight)
			
func moveFinal(checkColor):
	if checkColor == false:
		moveWithPin()
	elif checkColor == true and pieceProtectTheKing == true:
		if pieceProtectsAgainstAnAttack == false:
			defenceMove(attackerPositionshiftI,attackerPositionshiftJ)
			defenceMove(attackerPositionshift2I,attackerPositionshift2J)
			defenceMove(attackerPositionshift3I,attackerPositionshift3J)
			
func _on_area_2d_area_entered(area):
		var pieceName = area.get_parent().get_name()
		if promoteInProgress == false:
			if white == true and GlobalValueChessGame.turnWhite == false:
				if "Black" in pieceName and dragging == false :
					get_node("/root/Game/ChessBoard/" + pieceName).queue_free()
			elif white == false and GlobalValueChessGame.turnWhite == true:
				if "White" in pieceName and dragging == false :
					get_node("/root/Game/ChessBoard/" + pieceName).queue_free()
				
func checkMaxMove(dx, dy):
	for f in range (1,9):
		if chessBoard[i+(f*dy)][j+(f*dx)] != "0":
			if chessBoard[i+(f*dy)][j+(f*dx)] == "x":
				return f
			else:
				return f + 1
				
func checkMaxAllMove():
	maxMoveRight = checkMaxMove(1,0)
	maxMoveLeft = checkMaxMove(-1,0)
	maxMoveDown = checkMaxMove(0,1)
	maxMoveUp = checkMaxMove(0,-1)
	maxMoveDownRight = checkMaxMove(1,1)
	maxMoveDownLeft = checkMaxMove(-1,1)
	maxMoveUpLeft = checkMaxMove(-1,-1)
	maxMoveUpRight = checkMaxMove(1,-1)
	
func findDirectionAttackRow(dx, dy, rookColor, queenColor):
	for f in range(1,9):
		if chessBoard[i+(dy*f)][j+(dx*f)] == "x":
			break
		elif chessBoard[i+(dy*f)][j+(dx*f)] != "0":
			if chessBoard[i+(dy*f)][j+(dx*f)].begins_with(rookColor)\
			or chessBoard[i+(dy*f)][j+(dx*f)].begins_with(queenColor):
				if dx == 0 and dy == -1:
					directionAttackProtectKing = "Haut"
				elif dx == 0 and dy == 1:
					directionAttackProtectKing = "Bas"
				elif dx == 1 and dy == 0:
					directionAttackProtectKing = "Droite"
				elif dx == -1 and dy == 0:
					directionAttackProtectKing = "Gauche"
				break
			else:
				break

func findDirectionAttackDiagonal(dx, dy, bishopColor, queenColor):
	for f in range(1,9):
		if chessBoard[i+(dy*f)][j+(dx*f)] == "x":
			break
		elif chessBoard[i+(dy*f)][j+(dx*f)] != "0":
			if chessBoard[i+(dy*f)][j+(dx*f)].begins_with(bishopColor)\
			or chessBoard[i+(dy*f)][j+(dx*f)].begins_with(queenColor):
				if dx == 1 and dy == -1:
					directionAttackProtectKing = "Haut/Droite"
				elif dx == -1 and dy == -1:
					directionAttackProtectKing = "Haut/Gauche"
				elif dx == 1 and dy == 1:
					directionAttackProtectKing = "Bas/Droite"
				elif dx == -1 and dy == 1:
					directionAttackProtectKing = "Bas/Gauche"
				break
			else:
				break

func directionOfAttack(bishopColor, rookColor, queenColor):
	#On regarde d'où vient l'attaque
	directionAttackProtectKing = ""
	#Lignes
	findDirectionAttackRow(0, -1, rookColor, queenColor)
	findDirectionAttackRow(0, 1, rookColor, queenColor)
	findDirectionAttackRow(1, 0, rookColor, queenColor)
	findDirectionAttackRow(1, 0, rookColor, queenColor)
	
	#Diagonales
	findDirectionAttackDiagonal(1, -1, bishopColor, queenColor)
	findDirectionAttackDiagonal(-1, -1, bishopColor, queenColor)
	findDirectionAttackDiagonal(1, 1, bishopColor, queenColor)
	findDirectionAttackDiagonal(-1, 1, bishopColor, queenColor)
	
func findtheKingIsBehind(dx, dy, kingColor):
	for f in range(1,9):
		if chessBoard[i+(dy*f)][j+(dx*f)] == "x":
			break
		elif chessBoard[i+(dy*f)][j+(dx*f)] != "0":
			if chessBoard[i+(dy*f)][j+(dx*f)].begins_with(kingColor):
				pieceProtectsAgainstAnAttack = true
				break
			else:
				break

func theKingIsBehind():
	#Ensuite, on regarde si le roi est derrière la pièce
	#qui le protège de l'attaque qui vient dans cette direction
	var kingColor = ""
	if GlobalValueChessGame.turnWhite == true :
		directionOfAttack("BishopBlack", "RookBlack", "QueenBlack")
		kingColor = "KingWhite"
	elif GlobalValueChessGame.turnWhite == false :
		directionOfAttack("BishopWhite", "RookWhite", "QueenWhite")
		kingColor = "KingBlack"
		
	pieceProtectsAgainstAnAttack = false
	if directionAttackProtectKing == "Haut":
		#On cherche vers le bas
		findtheKingIsBehind(0, 1, kingColor)
	elif directionAttackProtectKing == "Bas":
		#On cherche vers le haut
		findtheKingIsBehind(0, -1, kingColor)
	elif directionAttackProtectKing == "Droite":
		#On cherche vers la gauche
		findtheKingIsBehind(-1, 0, kingColor)
	elif directionAttackProtectKing == "Gauche":
		#On cherche vers la droite
		findtheKingIsBehind(1, 0, kingColor)
	elif directionAttackProtectKing == "Haut/Droite":
		#On cherche vers le Bas/Gauche
		findtheKingIsBehind(-1, 1, kingColor)
	elif directionAttackProtectKing == "Haut/Gauche":
		#On cherche vers le Bas/Droite
		findtheKingIsBehind(1, 1, kingColor)
	elif directionAttackProtectKing == "Bas/Droite":
		#On cherche vers le Haut/Gauche
		findtheKingIsBehind(-1, -1, kingColor)
	elif directionAttackProtectKing == "Bas/Gauche":
		#On cherche vers le Haut/Droite
		findtheKingIsBehind(1, -1, kingColor)

func get_promoteInProgress():
	return promoteInProgress

func createNewPieceMovePreview(dx,dy,f,color):
	var previewSprite = Sprite2D.new()
	previewSprite.texture = load("res://Image/Pieces/"+ color + "/queen_" + color.to_lower() +  ".png")
	previewSprite.centered = true
	previewSprite.position.x = Position.x + positionChessBoard.x + (100 * f*dx)
	previewSprite.position.y = Position.y + positionChessBoard.y + (100 * f*dy)
	previewSprite.z_index = 9
	previewSprite.modulate.a = 0.5
	get_node("/root/Game/MovePreview").add_child(previewSprite)

func createNewPieceDefenceMovePreview(attackI, attackJ, color):
	var previewSprite = Sprite2D.new()
	previewSprite.texture = load("res://Image/Pieces/"+ color + "/queen_" + color.to_lower() +  ".png")
	previewSprite.centered = true
	previewSprite.position.x = Position.x + positionChessBoard.x + (100 * (attackJ - j))
	previewSprite.position.y = Position.y + positionChessBoard.y + (100 * (attackI - i))
	previewSprite.z_index = 9
	previewSprite.modulate.a = 0.1
	get_node("/root/Game/MovePreview").add_child(previewSprite)

func previewMove(dx, dy, color, color2, attackI, attackJ, attack2I, attack2J, attack3I, attack3J):
	if (GlobalValueChessGame.checkWhite == false and white == true)\
	or (GlobalValueChessGame.checkBlack == false and white == false):
		for f in range (1,8):
			if chessBoard[i+(f*dy)][j+(f*dx)] == "x":
				break
			if chessBoard[i+(f*dy)][j+(f*dx)] == "0":
				createNewPieceMovePreview(dx,dy,f,color)
			elif chessBoard[i+(f*dy)][j+(f*dx)] != "0" and color2 in chessBoard[i+(f*dy)][j+(f*dx)]:
				createNewPieceMovePreview(dx,dy,f,color)
				break
			elif chessBoard[i+(f*dy)][j+(f*dx)] != "0" and color in chessBoard[i+(f*dy)][j+(f*dx)]:
				break
	elif (GlobalValueChessGame.checkWhite == true and white == true)\
	or (GlobalValueChessGame.checkBlack == true and white == false):
		if chessBoard[attackI][attackJ] == "0"\
		or chessBoard[attackI][attackJ] != "0":
			createNewPieceDefenceMovePreview(attackI, attackJ, color)
		if chessBoard[attack2I][attack2J] == "0"\
		or chessBoard[attack2I][attack2J] != "0":
			createNewPieceDefenceMovePreview(attack2I, attack2J, color)
		if chessBoard[attack3I][attack3J] == "0"\
		or chessBoard[attack3I][attack3J] != "0":
			createNewPieceDefenceMovePreview(attack3I, attack3J, color)
			
func previewMovePattern(color, color2):
	if pieceProtectsAgainstAnAttack == false:
		previewMove(0, -1, color, color2,attackerPositionshiftI,attackerPositionshiftJ,attackerPositionshift2I,attackerPositionshift2J,attackerPositionshift3I,attackerPositionshift3J)
		previewMove(0, 1, color, color2,attackerPositionshiftI,attackerPositionshiftJ,attackerPositionshift2I,attackerPositionshift2J,attackerPositionshift3I,attackerPositionshift3J)
		previewMove(-1, 0, color, color2,attackerPositionshiftI,attackerPositionshiftJ,attackerPositionshift2I,attackerPositionshift2J,attackerPositionshift3I,attackerPositionshift3J)
		previewMove(1, 0, color, color2,attackerPositionshiftI,attackerPositionshiftJ,attackerPositionshift2I,attackerPositionshift2J,attackerPositionshift3I,attackerPositionshift3J)
		previewMove(1, -1, color, color2,attackerPositionshiftI,attackerPositionshiftJ,attackerPositionshift2I,attackerPositionshift2J,attackerPositionshift3I,attackerPositionshift3J)
		previewMove(-1, 1, color, color2,attackerPositionshiftI,attackerPositionshiftJ,attackerPositionshift2I,attackerPositionshift2J,attackerPositionshift3I,attackerPositionshift3J)
		previewMove(-1, -1, color, color2,attackerPositionshiftI,attackerPositionshiftJ,attackerPositionshift2I,attackerPositionshift2J,attackerPositionshift3I,attackerPositionshift3J)
		previewMove(1, 1, color, color2,attackerPositionshiftI,attackerPositionshiftJ,attackerPositionshift2I,attackerPositionshift2J,attackerPositionshift3I,attackerPositionshift3J)
	elif pieceProtectsAgainstAnAttack == true:
		if directionAttackProtectKing == "Haut" or directionAttackProtectKing == "Bas":
			previewMove(0, -1, color, color2,attackerPositionshiftI,attackerPositionshiftJ,attackerPositionshift2I,attackerPositionshift2J,attackerPositionshift3I,attackerPositionshift3J)
			previewMove(0, 1, color, color2,attackerPositionshiftI,attackerPositionshiftJ,attackerPositionshift2I,attackerPositionshift2J,attackerPositionshift3I,attackerPositionshift3J)
		elif directionAttackProtectKing == "Droite" or directionAttackProtectKing == "Gauche":
			previewMove(-1, 0, color, color2,attackerPositionshiftI,attackerPositionshiftJ,attackerPositionshift2I,attackerPositionshift2J,attackerPositionshift3I,attackerPositionshift3J)
			previewMove(1, 0, color, color2,attackerPositionshiftI,attackerPositionshiftJ,attackerPositionshift2I,attackerPositionshift2J,attackerPositionshift3I,attackerPositionshift3J)
		elif directionAttackProtectKing == "Haut/Droite" or directionAttackProtectKing == "Bas/Gauche":
			previewMove(1, -1, color, color2,attackerPositionshiftI,attackerPositionshiftJ,attackerPositionshift2I,attackerPositionshift2J,attackerPositionshift3I,attackerPositionshift3J)
			previewMove(-1, 1, color, color2,attackerPositionshiftI,attackerPositionshiftJ,attackerPositionshift2I,attackerPositionshift2J,attackerPositionshift3I,attackerPositionshift3J)
		elif directionAttackProtectKing == "Haut/Gauche" or directionAttackProtectKing == "Bas/Droite":
			previewMove(-1, -1, color, color2,attackerPositionshiftI,attackerPositionshiftJ,attackerPositionshift2I,attackerPositionshift2J,attackerPositionshift3I,attackerPositionshift3J)
			previewMove(1, 1, color, color2,attackerPositionshiftI,attackerPositionshiftJ,attackerPositionshift2I,attackerPositionshift2J,attackerPositionshift3I,attackerPositionshift3J)

func previewAllMove():
	if white == true:
		previewMovePattern("White", "Black")
	elif white == false:
		previewMovePattern("Black", "White")

func deleteAllChildMovePreview():
	var numberOfChildren = get_node("/root/Game/MovePreview").get_child_count()
	for f in range(numberOfChildren):
		get_node("/root/Game/MovePreview").get_child(f).queue_free()

func lastMovePlay():
	modulate.r = 0
	modulate.g = 0

func resetLastMovePlay():
	var numberOfChildren = get_parent().get_child_count()
	
	for f in range(numberOfChildren):
		if get_parent().get_child(f).modulate.r == 0\
		and get_parent().get_child(f).modulate.g == 0:
			get_parent().get_child(f).modulate = Color(1, 1, 1, 1)
			break

func playWhite():
	if self.position.y == 750 :
		white = true
	elif self.position.y == 50:
		white = false
		
	if white == true:
		set_name("QueenWhite") #Si la pièce est déjà créer alors l'autre se nommera avec un chiffre à la fin
		nameOfPiece = get_name()
		if nameOfPiece == "QueenWhite":
			i = 9
			j = 5
			Position = Vector2(350,750)
	else:
		i = 2
		j = 5
		Position = Vector2(350, 50)
		texture = textureBlack
		set_name("QueenBlack")
		nameOfPiece = get_name()
		
	print(nameOfPiece, " i: ", i, " j: ", j, " new position: ", Position )

func playBlack():
	if self.position.y == 750 :
		white = false
	elif self.position.y == 50:
		white = true
		
	if white == true:
		set_name("QueenWhite") #Si la pièce est déjà créer alors l'autre se nommera avec un chiffre à la fin
		nameOfPiece = get_name()
		if nameOfPiece == "QueenWhite":
			i = 2
			j = 5
			Position = Vector2(350,50)
	else:
		i = 9
		j = 5
		Position = Vector2(350, 750)
		texture = textureBlack
		set_name("QueenBlack")
		nameOfPiece = get_name()
		
	print(nameOfPiece, " i: ", i, " j: ", j, " new position: ", Position )
