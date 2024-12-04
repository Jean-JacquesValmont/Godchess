extends Sprite2D

var promotionID
var piecesBlack = [["Pawn", "" , "Pion.png", 50, 250],["Pawn", "2", "Pion.png", 100, 250],["Pawn", "3", "Pion.png", 150, 250],["Pawn", "4", "Pion.png", 200, 250],
	["Pawn", "5", "Pion.png", 250, 250],["Pawn", "6", "Pion.png", 300, 250],["Pawn", "7", "Pion.png", 350, 250],["Pawn", "8", "Pion.png", 400, 250],
	["Knight", "", "Cavalier.png", 50, 300],["Knight", "2", "Cavalier.png", 100, 300],["Bishop", "", "Fou.png", 150, 300],["Bishop", "2", "Fou.png", 200, 300],
	["Rook", "", "Tour.png", 250, 300],["Rook", "2", "Tour.png", 300, 300],["Queen", "", "Reine.png", 350, 300]
	]
var piecesWhite = [["Pawn",  "", "Pion.png", 1450, 775],["Pawn", "2", "Pion.png", 1500, 775],["Pawn", "3", "Pion.png", 1550, 775],["Pawn", "4", "Pion.png", 1600, 775],
	["Pawn", "5", "Pion.png", 1650, 775],["Pawn", "6", "Pion.png", 1700, 775],["Pawn", "7", "Pion.png", 1775, 775],["Pawn", "8", "Pion.png", 1800, 775],
	["Knight", "", "Cavalier.png", 1450, 825],["Knight", "2", "Cavalier.png", 1500, 825],["Bishop", "", "Fou.png", 1550, 825],["Bishop", "2", "Fou.png", 1600, 825],
	["Rook", "", "Tour.png", 1650, 825],["Rook", "2", "Tour.png", 1700, 825],["Queen", "", "Reine.png", 1750, 825]
]

func _ready():
	pass

func _process(delta):
	if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
		for pieceData in piecesBlack:
			var pieceType = pieceData[0]
			var number = pieceData[1]  # Type de la pièce (Pawn, Knight, Bishop, Rook, Queen)
			var piecePNG = pieceData[2] # Le .png
			var positionX = pieceData[3]  # Position x du sprite
			var positionY = pieceData[4]  # Position y du sprite

			# Vérifier si le nœud n'existe pas déjà
			if get_node_or_null(pieceType + "Black" + number) == null:
			# Créer un nouveau sprite
				var deadSprite = Sprite2D.new()
				#deadSprite.texture = load("res://Image/Pieces/Black/" + pieceType.to_lower() + "_black.png")
				deadSprite.texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer2 + "/Pieces/Base pièce doubler - " + piecePNG)
				deadSprite.name = pieceType + "Black" + number
				deadSprite.centered = true
				deadSprite.position.x = positionX
				deadSprite.position.y = positionY
				deadSprite.scale.x = 0.25
				deadSprite.scale.y = 0.25
				
				# Ajouter le sprite comme enfant du nœud gameScreen
				get_node("/root/Game/DisplayPiecesDied").add_child(deadSprite)
				
		for pieceData in piecesWhite:
			var pieceType = pieceData[0]
			var number = pieceData[1]  # Type de la pièce (Pawn, Knight, Bishop, Rook, Queen)
			var piecePNG = pieceData[2] # Le .png
			var positionX = pieceData[3]  # Position x du sprite
			var positionY = pieceData[4]  # Position y du sprite

			# Vérifier si le nœud n'existe pas déjà
			if get_node_or_null(pieceType + "White" + number) == null:
			# Créer un nouveau sprite
				var deadSprite = Sprite2D.new()
				#deadSprite.texture = load("res://Image/Pieces/White/" + pieceType.to_lower() + "_white.png")
				deadSprite.texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer1 + "/Pieces/Base pièce doubler - " + piecePNG)
				deadSprite.name = pieceType + "White" + number
				deadSprite.centered = true
				deadSprite.position.x = positionX
				deadSprite.position.y = positionY
				deadSprite.scale.x = 0.25
				deadSprite.scale.y = 0.25
				
				# Ajouter le sprite comme enfant du nœud gameScreen
				get_node("/root/Game/DisplayPiecesDied").add_child(deadSprite)

	if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1:
		for pieceData in piecesBlack:
			var pieceType = pieceData[0]
			var number = pieceData[1]  # Type de la pièce (Pawn, Knight, Bishop, Rook, Queen)
			var piecePNG = pieceData[2] # Le .png
			var positionX = pieceData[3]  # Position x du sprite
			var positionY = pieceData[4]  # Position y du sprite

			# Vérifier si le nœud n'existe pas déjà
			if get_node_or_null(pieceType + "White" + number) == null:
			# Créer un nouveau sprite
				var deadSprite = Sprite2D.new()
				#deadSprite.texture = load("res://Image/Pieces/White/" + pieceType.to_lower() + "_white.png")
				deadSprite.texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer1 + "/Pieces/Base pièce doubler - " + piecePNG)
				deadSprite.name = pieceType + "White" + number
				deadSprite.centered = true
				deadSprite.position.x = positionX
				deadSprite.position.y = positionY
				deadSprite.scale.x = 0.25
				deadSprite.scale.y = 0.25
				
				# Ajouter le sprite comme enfant du nœud gameScreen
				get_node("/root/Game/DisplayPiecesDied").add_child(deadSprite)
				
		for pieceData in piecesWhite:
			var pieceType = pieceData[0]
			var number = pieceData[1]  # Type de la pièce (Pawn, Knight, Bishop, Rook, Queen)
			var piecePNG = pieceData[2] # Le .png
			var positionX = pieceData[3]  # Position x du sprite
			var positionY = pieceData[4]  # Position y du sprite

			# Vérifier si le nœud n'existe pas déjà
			if get_node_or_null(pieceType + "Black" + number) == null:
			# Créer un nouveau sprite
				var deadSprite = Sprite2D.new()
				#deadSprite.texture = load("res://Image/Pieces/Black/" + pieceType.to_lower() + "_black.png")
				deadSprite.texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer2 + "/Pieces/Base pièce doubler - " + piecePNG)
				deadSprite.name = pieceType + "Black" + number
				deadSprite.centered = true
				deadSprite.position.x = positionX
				deadSprite.position.y = positionY
				deadSprite.scale.x = 0.25
				deadSprite.scale.y = 0.25
				
				# Ajouter le sprite comme enfant du nœud gameScreen
				get_node("/root/Game/DisplayPiecesDied").add_child(deadSprite)

func blockMoveDuringPromotion(promoteInProgress):
	var numberOfChildren = get_child_count()
	
	for f in range(numberOfChildren):
		var piece = get_child(f)
		if piece.has_method("get_promoteInProgress"):
			# Le nœud a une méthode pour récupérer promoteInProgress
			var promoteInProgressValue = piece.get_promoteInProgress()
			if promoteInProgressValue != null:
				#print("Variable existe dans: ", piece.get_name())
				piece.promoteInProgress = promoteInProgress
				#print("piece.promoteInProgress: ", piece.promoteInProgress)
			else:
				pass
				#print("Variable est nulle dans: ", piece.get_name())
		else:
			pass
			#print("La méthode get_promoteInProgress n'existe pas dans: ", piece.get_name())

func updateVariablePiecePromoted():
	print("Enter in updateVariablePiecePromoted")

	var lastChild = get_child(get_child_count() - 1)
	var pieceName = lastChild.get_name()
	if "White" in pieceName:
		lastChild.white = true
	elif "Black" in pieceName:
		lastChild.white = false
	if GlobalValueChessGame.turnWhite == true:
		if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
			lastChild.i = 2
			for f in range(2,9):
				print("piece.position.x: ", lastChild.position.x)
				if lastChild.position.x == ((f - 2) * 100) + 50:
					lastChild.j = f
					break
			lastChild.position.x = ((lastChild.j - 2) * 100) + 50
			lastChild.position.y = 50
			lastChild.Position = Vector2(((lastChild.j - 2) * 100) + 50, 50)
			lastChild.positionChessBoard = global_position
			lastChild.chessBoard = get_node("KingWhite").chessBoard
			if lastChild.white == true:
				lastChild.playerID = OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id
		elif OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1:
			lastChild.i = 9
			for f in range(2,9):
				if lastChild.position.x == ((f - 2) * 100) + 50:
					lastChild.j = f
					break
			lastChild.position.x = ((lastChild.j - 2) * 100) + 50
			lastChild.position.y = 750
			lastChild.Position = Vector2(((lastChild.j - 2) * 100) + 50, 750)
			lastChild.positionChessBoard = global_position
			lastChild.chessBoard = get_node("KingBlack").chessBoard
			if lastChild.white == false:
				lastChild.playerID = OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id
		lastChild.nameOfPiece = pieceName
		lastChild.initialPosition = false
	elif GlobalValueChessGame.turnWhite == false:
		if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
			lastChild.i = 9
			for f in range(2,9):
				print("piece.position.x: ", lastChild.position.x)
				if lastChild.position.x == ((f - 2) * 100) + 50:
					lastChild.j = f
					break
			lastChild.position.x = ((lastChild.j - 2) * 100) + 50
			lastChild.position.y = 750
			lastChild.Position = Vector2(((lastChild.j - 2) * 100) + 50, 750)
			lastChild.positionChessBoard = global_position
			lastChild.chessBoard = get_node("KingWhite").chessBoard
			if lastChild.white == true:
				lastChild.playerID = OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id
		elif OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1:
			lastChild.i = 2
			for f in range(2,9):
				if lastChild.position.x == ((f - 2) * 100) + 50:
					lastChild.j = f
					break
			lastChild.position.x = ((lastChild.j - 2) * 100) + 50
			lastChild.position.y = 50
			lastChild.Position = Vector2(((lastChild.j - 2) * 100) + 50, 50)
			lastChild.positionChessBoard = global_position
			lastChild.chessBoard = get_node("KingBlack").chessBoard
			if lastChild.white == false:
				lastChild.playerID = OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id
		lastChild.nameOfPiece = pieceName
		lastChild.initialPosition = false
	
	#for f in range(numberOfChildren):
		#var piece = get_child(f)
		#var pieceName = piece.get_name()
		#print("pieceName: ", pieceName)
		#if piece.get_instance_id() == promotionID:
			#if "White" in pieceName:
				#piece.white = true
			#elif "Black" in pieceName:
				#piece.white = false
			#if GlobalValueChessGame.turnWhite == true:
				#if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
					#piece.i = 2
					#for ff in range(2,9):
						#print("piece.position.x: ", piece.position.x)
						#if piece.position.x == ((ff - 2) * 100) + 50:
							#piece.j = ff
							#break
					#piece.position.x = ((piece.j - 2) * 100) + 50
					#piece.position.y = 50
					#piece.Position = Vector2(((piece.j - 2) * 100) + 50, 50)
					#piece.positionChessBoard = global_position
					#piece.chessBoard = get_node("KingWhite").chessBoard
					#if piece.white == true:
						#piece.playerID = OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id
				#elif OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1:
					#piece.i = 9
					#for ff in range(2,9):
						#if piece.position.x == ((ff - 2) * 100) + 50:
							#piece.j = ff
							#break
					#piece.position.x = ((piece.j - 2) * 100) + 50
					#piece.position.y = 750
					#piece.Position = Vector2(((piece.j - 2) * 100) + 50, 750)
					#piece.positionChessBoard = global_position
					#piece.chessBoard = get_node("KingBlack").chessBoard
					#if piece.white == false:
						#piece.playerID = OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id
				#piece.nameOfPiece = pieceName
				#piece.initialPosition = false
				#break
			#elif GlobalValueChessGame.turnWhite == false:
				#if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
					#piece.i = 9
					#for ff in range(2,9):
						#print("piece.position.x: ", piece.position.x)
						#if piece.position.x == ((ff - 2) * 100) + 50:
							#piece.j = ff
							#break
					#piece.position.x = ((piece.j - 2) * 100) + 50
					#piece.position.y = 750
					#piece.Position = Vector2(((piece.j - 2) * 100) + 50, 750)
					#piece.positionChessBoard = global_position
					#piece.chessBoard = get_node("KingWhite").chessBoard
					#if piece.white == true:
						#piece.playerID = OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id
				#elif OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1:
					#piece.i = 2
					#for ff in range(2,9):
						#if piece.position.x == ((ff - 2) * 100) + 50:
							#piece.j = ff
							#break
					#piece.position.x = ((piece.j - 2) * 100) + 50
					#piece.position.y = 50
					#piece.Position = Vector2(((piece.j - 2) * 100) + 50, 50)
					#piece.positionChessBoard = global_position
					#piece.chessBoard = get_node("KingBlack").chessBoard
					#if piece.white == false:
						#piece.playerID = OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id
				#piece.nameOfPiece = pieceName
				#piece.initialPosition = false
				#break

func _on_pawn_promotion_turn(promoteInProgress):
	print("Enter _on_pawn_promotion_turn")
	blockMoveDuringPromotion(promoteInProgress)

func _on_pawn_2_promotion_turn(promoteInProgress):
	print("Enter _on_pawn_2_promotion_turn")
	blockMoveDuringPromotion(promoteInProgress)

func _on_pawn_3_promotion_turn(promoteInProgress):
	print("Enter _on_pawn_3_promotion_turn")
	blockMoveDuringPromotion(promoteInProgress)

func _on_pawn_4_promotion_turn(promoteInProgress):
	print("Enter _on_pawn_4_promotion_turn")
	blockMoveDuringPromotion(promoteInProgress)

func _on_pawn_5_promotion_turn(promoteInProgress):
	print("Enter _on_pawn_5_promotion_turn")
	blockMoveDuringPromotion(promoteInProgress)

func _on_pawn_6_promotion_turn(promoteInProgress):
	print("Enter _on_pawn_6_promotion_turn")
	blockMoveDuringPromotion(promoteInProgress)

func _on_pawn_7_promotion_turn(promoteInProgress):
	print("Enter _on_pawn_7_promotion_turn")
	blockMoveDuringPromotion(promoteInProgress)

func _on_pawn_8_promotion_turn(promoteInProgress):
	print("Enter _on_pawn_8_promotion_turn")
	blockMoveDuringPromotion(promoteInProgress)

func _on_pawn_9_promotion_turn(promoteInProgress):
	print("Enter _on_pawn_9_promotion_turn")
	blockMoveDuringPromotion(promoteInProgress)

func _on_pawn_10_promotion_turn(promoteInProgress):
	print("Enter _on_pawn_10_promotion_turn")
	blockMoveDuringPromotion(promoteInProgress)

func _on_pawn_11_promotion_turn(promoteInProgress):
	print("Enter _on_pawn_11_promotion_turn")
	blockMoveDuringPromotion(promoteInProgress)

func _on_pawn_12_promotion_turn(promoteInProgress):
	print("Enter _on_pawn_12_promotion_turn")
	blockMoveDuringPromotion(promoteInProgress)

func _on_pawn_13_promotion_turn(promoteInProgress):
	print("Enter _on_pawn_13_promotion_turn")
	blockMoveDuringPromotion(promoteInProgress)

func _on_pawn_14_promotion_turn(promoteInProgress):
	print("Enter _on_pawn_14_promotion_turn")
	blockMoveDuringPromotion(promoteInProgress)

func _on_pawn_15_promotion_turn(promoteInProgress):
	print("Enter _on_pawn_15_promotion_turn")
	blockMoveDuringPromotion(promoteInProgress)

func _on_pawn_16_promotion_turn(promoteInProgress):
	print("Enter _on_pawn_16_promotion_turn")
	blockMoveDuringPromotion(promoteInProgress)

func _on_pawn_script_changed():
	updateVariablePiecePromoted()

func _on_pawn_2_script_changed():
	updateVariablePiecePromoted()

func _on_pawn_3_script_changed():
	updateVariablePiecePromoted()

func _on_pawn_4_script_changed():
	updateVariablePiecePromoted()

func _on_pawn_5_script_changed():
	updateVariablePiecePromoted()

func _on_pawn_6_script_changed():
	updateVariablePiecePromoted()

func _on_pawn_7_script_changed():
	updateVariablePiecePromoted()

func _on_pawn_8_script_changed():
	updateVariablePiecePromoted()

func _on_pawn_9_script_changed():
	updateVariablePiecePromoted()

func _on_pawn_10_script_changed():
	updateVariablePiecePromoted()

func _on_pawn_11_script_changed():
	updateVariablePiecePromoted()

func _on_pawn_12_script_changed():
	updateVariablePiecePromoted()

func _on_pawn_13_script_changed():
	updateVariablePiecePromoted()

func _on_pawn_14_script_changed():
	updateVariablePiecePromoted()

func _on_pawn_15_script_changed():
	updateVariablePiecePromoted()

func _on_pawn_16_script_changed():
	updateVariablePiecePromoted()
