extends Sprite2D

signal kingSizeCastelingSignal
signal queenSizeCastelingSignal

var dragging = false
var clickRadius = 50
var dragOffset = Vector2()
var moveCase = GlobalValueChessGame.oneMoveCase
var chessBoard = GlobalValueChessGame.chessBoard
var attackWhite = GlobalValueChessGame.attackPieceWhiteOnTheChessboard
var attackBlack = GlobalValueChessGame.attackPieceBlackOnTheChessboard
var i = 9
var j = 6
var positionChessBoard
var Position = Vector2(450, 750)
@onready var nameOfPiece = get_name()
var initialPosition = true
var white = true
var textureWhite = preload("res://Image/Pieces/White/king_white.png")
var textureBlack = preload("res://Image/Pieces/Black/king_black.png")
var promoteInProgress = false
var playerID

func _ready():
	await get_tree().process_frame
	positionChessBoard = get_parent().global_position
#	if VariableGlobalOption.modeEditor == false:
	if GlobalValueChessGame.startWhite == true:
		playWhite()
	elif GlobalValueChessGame.startWhite == false:
		playBlack()
#	elif VariableGlobalOption.modeEditor == true:
#		if white == true:
#			texture = textureWhite
#			playModeEditor("White")
#		elif white == false:
#			texture = textureBlack
#			playModeEditor("Black")
#		print(nameOfPiece, " i: ", i, " j: ", j, " PositionX: ", Position.x, " PositionY: ", Position.y )
#		for f in range(0,12):
#			print(chessBoard[f])
	if white == true and OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
		playerID = OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id
	elif white == false and OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1:
		playerID = OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id

func _process(delta):
	pass

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
					previewAllMove()
			# Stop dragging if the button is released.
			if dragging and not event.pressed:
				deleteAllChildMovePreview()
				get_node("Area2D/CollisionShape2D").disabled = false
				if white == true and GlobalValueChessGame.turnWhite == true:
					allMove("RookWhite","RookWhite2",attackBlack)
				elif white == false and GlobalValueChessGame.turnWhite == false:
					allMove("RookBlack","RookBlack2",attackWhite)
				self.position = Vector2(Position.x, Position.y)
				dragging = false
				z_index = 0
				for f in range(0,12):
					print(chessBoard[f])
				
		if event is InputEventMouseMotion and dragging:
			# While dragging, move the sprite with the mouse.
			self.position = event.position - positionChessBoard
			get_node("Area2D/CollisionShape2D").disabled = true
		
func move(dx, dy) :
	for f in range (1,2):
		var targetCaseX = dx*(f*moveCase)
		var targetCaseY = dy*(f*moveCase)
		var newTargetCaseX = targetCaseX + positionChessBoard.x
		var newTargetCaseY = targetCaseY + positionChessBoard.y
		if global_position.x >= (Position.x - 50) + newTargetCaseX  and global_position.x <= (Position.x + 50) + newTargetCaseX \
		and global_position.y >= (Position.y - 50) + newTargetCaseY and global_position.y <= (Position.y + 50) + newTargetCaseY \
		and ((chessBoard[i+(dy*f)][j+(dx*f)] == "0" or "Black" in chessBoard[i+(dy*f)][j+(dx*f)]) and GlobalValueChessGame.turnWhite == true\
		and GlobalValueChessGame.attackPieceBlackOnTheChessboard[i+(dy*f)][j+(dx*f)] == 0\
		or (chessBoard[i+(dy*f)][j+(dx*f)] == "0" or "White" in chessBoard[i+(dy*f)][j+(dx*f)]) and GlobalValueChessGame.turnWhite == false\
		and GlobalValueChessGame.attackPieceWhiteOnTheChessboard[i+(dy*f)][j+(dx*f)] == 0):
			rpc("movePiece",f,targetCaseX,targetCaseY,dx,dy)
#			self.position = Vector2((Position.x + targetCaseX), (Position.y + targetCaseY))
#			Position = Vector2(self.position.x, self.position.y)
#			chessBoard[i][j] = "0"
#			i=i+(dy*f)
#			j=j+(dx*f)
#			chessBoard[i][j] = nameOfPiece.replace("@", "")
#			GlobalValueChessGame.turnWhite = !GlobalValueChessGame.turnWhite
#			initialPosition = false
#			get_node("SoundMovePiece").play()
#			resetLastMovePlay()
#			lastMovePlay()
			break
		elif global_position.x >= get_parent().texture.get_width() + positionChessBoard.x\
		 or global_position.y >= get_parent().texture.get_height() + positionChessBoard.y :
			self.position = Vector2(Position.x, Position.y)
			
func allMove(rookColor,rookColor2,attackColor):
	move(1,0)
	move(0,1)
	move(-1,0)
	move(0,-1)
	move(1,1)
	move(1,-1)
	move(-1,1)
	move(-1,-1)
	kingSizeCasteling(1,1,rookColor2,attackColor)
	queenSizeCasteling(-1,1,rookColor,attackColor)
	
func _on_area_2d_area_entered(area):
		var pieceName = area.get_parent().get_name()
		if white == true and GlobalValueChessGame.turnWhite == false:
			if "Black" in pieceName and dragging == false :
#				VariableGlobalOption.pieceTaken = true
				get_node("/root/Game/ChessBoard/" + pieceName).queue_free()
		elif white == false and GlobalValueChessGame.turnWhite == true:
			if "White" in pieceName and dragging == false :
#				VariableGlobalOption.pieceTaken = true
				get_node("/root/Game/ChessBoard/" + pieceName).queue_free()
				
func kingSizeCasteling(dx, dy, rookColor, attackColor):
		var targetCaseX = dx*(2*moveCase)
		var targetCaseY = dy*(0*moveCase)
		var newTargetCaseX = targetCaseX + positionChessBoard.x
		var newTargetCaseY = targetCaseY + positionChessBoard.y
		if global_position.x >= (Position.x - 50) + newTargetCaseX  and global_position.x <= (Position.x + 50) + newTargetCaseX \
		and global_position.y >= (Position.y - 50) + newTargetCaseY and global_position.y <= (Position.y + 50) + newTargetCaseY \
		and chessBoard[i][j+1] == "0" and chessBoard[i][j+2] == "0" and chessBoard[i][j+3].begins_with("Rook") \
		and attackColor[i][j] == 0 and attackColor[i][j+1] == 0 and attackColor[i][j+2] == 0 and initialPosition == true \
		and get_node("/root/Game/ChessBoard/" + rookColor).initialPosition == true:
			self.position = Vector2((Position.x + targetCaseX), (Position.y + targetCaseY))
			Position = Vector2(self.position.x, self.position.y)
			chessBoard[i][j] = "0"
			i=i
			j=j+(dx*2)
			chessBoard[i][j] = nameOfPiece.replace("@", "")
			initialPosition = false
			GlobalValueChessGame.turnWhite = !GlobalValueChessGame.turnWhite
			get_node("SoundMovePiece").play()
			resetLastMovePlay()
			lastMovePlay()
			emit_signal("kingSizeCastelingSignal")
		elif global_position.x >= get_parent().texture.get_width() + positionChessBoard.x\
		 or global_position.y >= get_parent().texture.get_height() + positionChessBoard.y :
			self.position = Vector2(Position.x, Position.y)
			
func queenSizeCasteling(dx, dy, rookColor, attackColor):
		var targetCaseX = dx*(2*moveCase)
		var targetCaseY = dy*(0*moveCase)
		var newTargetCaseX = targetCaseX + positionChessBoard.x
		var newTargetCaseY = targetCaseY + positionChessBoard.y
		if global_position.x >= (Position.x - 50) + newTargetCaseX and global_position.x <= (Position.x + 50) + newTargetCaseX \
		and global_position.y >= (Position.y - 50) + newTargetCaseY and global_position.y <= (Position.y + 50) + newTargetCaseY \
		and chessBoard[i][j-1] == "0" and chessBoard[i][j-2] == "0" and chessBoard[i][j-3] == "0" and chessBoard[i][j-4].begins_with("Rook") \
		and attackColor[i][j] == 0 and attackColor[i][j-1] == 0 and attackColor[i][j-2] == 0  and attackColor[i][j-3] == 0 and initialPosition == true \
		and get_node("/root/Game/ChessBoard/" + rookColor).initialPosition == true:
			self.position = Vector2((Position.x + targetCaseX), (Position.y + targetCaseY))
			Position = Vector2(self.position.x, self.position.y)
			chessBoard[i][j] = "0"
			i=i
			j=j+(dx*2)
			chessBoard[i][j] = nameOfPiece.replace("@", "")
			initialPosition = false
			GlobalValueChessGame.turnWhite = !GlobalValueChessGame.turnWhite
			get_node("SoundMovePiece").play()
			resetLastMovePlay()
			lastMovePlay()
			emit_signal("queenSizeCastelingSignal")
		elif global_position.x >= get_parent().texture.get_width() + positionChessBoard.x\
		 or global_position.y >= get_parent().texture.get_height() + positionChessBoard.y :
			self.position = Vector2(Position.x, Position.y)

func get_promoteInProgress():
	return promoteInProgress
	

func createNewPieceMovePreview(dx,dy,f,color):
	var previewSprite = Sprite2D.new()
	previewSprite.texture = load("res://Image/Pieces/"+ color + "/king_" + color.to_lower() +  ".png")
	previewSprite.centered = true
	previewSprite.position.x = Position.x + positionChessBoard.x + (100 * f*dx)
	previewSprite.position.y = Position.y + positionChessBoard.y + (100 * f*dy)
	previewSprite.z_index = 9
	previewSprite.modulate.a = 0.5
	get_node("/root/Game/MovePreview").add_child(previewSprite)

func previewMove(dx, dy, color, color2, attackColor):
	for f in range (1,2):
		if chessBoard[i+(f*dy)][j+(f*dx)] == "x":
			break
		if chessBoard[i+(f*dy)][j+(f*dx)] == "0" and attackColor[i+(f*dy)][j+(f*dx)] == 0:
			createNewPieceMovePreview(dx,dy,f,color)
		elif chessBoard[i+(f*dy)][j+(f*dx)] != "0" and color2 in chessBoard[i+(f*dy)][j+(f*dx)]\
		and attackColor[i+(f*dy)][j+(f*dx)] == 0:
			createNewPieceMovePreview(dx,dy,f,color)
			break
		elif chessBoard[i+(f*dy)][j+(f*dx)] != "0" and color in chessBoard[i+(f*dy)][j+(f*dx)]:
			break
			
func previewMovePattern(color, color2, attackPieceColorOnTheChessboard):
	previewMove(0, -1, color, color2, attackPieceColorOnTheChessboard)
	previewMove(0, 1, color, color2, attackPieceColorOnTheChessboard)
	previewMove(-1, 0, color, color2, attackPieceColorOnTheChessboard)
	previewMove(1, 0, color, color2, attackPieceColorOnTheChessboard)
	previewMove(1, -1, color, color2, attackPieceColorOnTheChessboard)
	previewMove(-1, 1, color, color2, attackPieceColorOnTheChessboard)
	previewMove(-1, -1, color, color2, attackPieceColorOnTheChessboard)
	previewMove(1, 1, color, color2, attackPieceColorOnTheChessboard)
	
func previewAllMove():
	if white == true:
		previewMovePattern("White", "Black", GlobalValueChessGame.attackPieceBlackOnTheChessboard)
	elif white == false:
		previewMovePattern("Black", "White", GlobalValueChessGame.attackPieceWhiteOnTheChessboard)

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
		set_name("KingWhite") #Si la pièce est déjà créer alors l'autre se nommera avec un chiffre à la fin
		nameOfPiece = get_name()
		if nameOfPiece == "KingWhite":
			i = 9
			j = 6
			Position = Vector2(450,750)
	else:
		i = 2
		j = 6
		Position = Vector2(450, 50)
		texture = textureBlack
		set_name("KingBlack")
		nameOfPiece = get_name()
		
	print(nameOfPiece, " i: ", i, " j: ", j, " new position: ", Position )

func playBlack():
	if self.position.y == 750 :
		white = false
	elif self.position.y == 50:
		white = true
		
	if white == true:
		set_name("KingWhite") #Si la pièce est déjà créer alors l'autre se nommera avec un chiffre à la fin
		nameOfPiece = get_name()
		if nameOfPiece == "KingWhite":
			i = 2
			j = 6
			Position = Vector2(450,50)
	else:
		i = 9
		j = 6
		Position = Vector2(450, 750)
		texture = textureBlack
		set_name("KingBlack")
		nameOfPiece = get_name()
		
	print(nameOfPiece, " i: ", i, " j: ", j, " new position: ", Position )

func playModeEditor(color):
	print("Enter in playWhiteModeEditor")
	set_name("King"+color)
	nameOfPiece = get_name()
	for f in range(10): 
		for ff in range(10):
			if global_position.x >= 100 + f * 100 and global_position.x <= 200 + f * 100\
			and global_position.y >= 100 + ff * 100 and global_position.y <= 200 + ff * 100:
				i = ff + 2
				j = f + 2
				Position.x = position.x
				Position.y = position.y
				chessBoard[i][j] = nameOfPiece.replace("@", "")

#func _on_area_2d_mouse_entered():
#	if VariableGlobalOption.modeEditor == true and VariableGlobalOption.modeDelete == true:
#		if white == true:
#			VariableGlobalOption.kingWhitePresent = false
#		elif white == false:
#			VariableGlobalOption.kingBlackPresent = false
#		chessBoard[i][j] = "0"
#		for f in range(0,12):
#			print(chessBoard[f])
#		queue_free()
