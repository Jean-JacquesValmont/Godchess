extends Sprite2D

var promotionID

func _ready():
	pass

func _process(delta):
	pass

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
	var numberOfChildren = get_child_count()
	
	for f in range(numberOfChildren):
		var piece = get_child(f)
		var pieceName = piece.get_name()
		print("pieceName: ", pieceName)
		if piece.get_instance_id() == promotionID:
			if "White" in pieceName:
				piece.white = true
			elif "Black" in pieceName:
				piece.white = false
			if GlobalValueChessGame.turnWhite == true:
				if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
					piece.i = 2
					for ff in range(2,9):
						print("piece.position.x: ", piece.position.x)
						if piece.position.x == ((ff - 2) * 100) + 50:
							piece.j = ff
							break
					piece.position.x = ((piece.j - 2) * 100) + 50
					piece.position.y = 50
					piece.Position = Vector2(((piece.j - 2) * 100) + 50, 50)
					piece.positionChessBoard = global_position
					piece.chessBoard = get_node("KingWhite").chessBoard
					if piece.white == true:
						piece.playerID = OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id
				elif OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1:
					piece.i = 9
					for ff in range(2,9):
						if piece.position.x == ((ff - 2) * 100) + 50:
							piece.j = ff
							break
					piece.position.x = ((piece.j - 2) * 100) + 50
					piece.position.y = 750
					piece.Position = Vector2(((piece.j - 2) * 100) + 50, 750)
					piece.positionChessBoard = global_position
					piece.chessBoard = get_node("KingBlack").chessBoard
					if piece.white == false:
						piece.playerID = OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id
				piece.nameOfPiece = pieceName
				piece.initialPosition = false
				break
			elif GlobalValueChessGame.turnWhite == false:
				if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
					piece.i = 9
					for ff in range(2,9):
						print("piece.position.x: ", piece.position.x)
						if piece.position.x == ((ff - 2) * 100) + 50:
							piece.j = ff
							break
					piece.position.x = ((piece.j - 2) * 100) + 50
					piece.position.y = 750
					piece.Position = Vector2(((piece.j - 2) * 100) + 50, 750)
					piece.positionChessBoard = global_position
					piece.chessBoard = get_node("KingWhite").chessBoard
					if piece.white == true:
						piece.playerID = OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id
				elif OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1:
					piece.i = 2
					for ff in range(2,9):
						if piece.position.x == ((ff - 2) * 100) + 50:
							piece.j = ff
							break
					piece.position.x = ((piece.j - 2) * 100) + 50
					piece.position.y = 50
					piece.Position = Vector2(((piece.j - 2) * 100) + 50, 50)
					piece.positionChessBoard = global_position
					piece.chessBoard = get_node("KingBlack").chessBoard
					if piece.white == false:
						piece.playerID = OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id
				piece.nameOfPiece = pieceName
				piece.initialPosition = false
				break

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
