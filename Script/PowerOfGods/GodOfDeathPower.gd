extends Node

var usePowerKing = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	usePowerKing = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Powers of God of Death
func deathPowerPawn(playerID, chessBoard):
	var countPawn = 8
	var randomPiece = ["PawnBlack","PawnBlack2","PawnBlack3","PawnBlack4","PawnBlack5","PawnBlack6","PawnBlack7","PawnBlack8"]
	var randomNumber = randi_range(0, 7)
	var findPiece = false

	# Compter le nombre de "PawnWhite" sur le plateau
	for i in range(2, 10):
		for j in range(2, 10):
			if chessBoard[i][j].begins_with("PawnWhite"):
				countPawn -= 1

	# Ajuster la plage de randomNumber en fonction de countPawn
	if countPawn == 4:
		randomPiece = ["PawnBlack","PawnBlack2","PawnBlack3","PawnBlack4","PawnBlack5","PawnBlack6","PawnBlack7","PawnBlack8","KnightBlack","KnightBlack2"]
		randomNumber = randi_range(0, 9)
	elif countPawn == 6:
		randomPiece = ["PawnBlack","PawnBlack2","PawnBlack3","PawnBlack4","PawnBlack5","PawnBlack6","PawnBlack7","PawnBlack8","KnightBlack","KnightBlack2","BishopBlack","BishopBlack2"]
		randomNumber = randi_range(0, 11)
	elif countPawn == 8:
		randomPiece = ["PawnBlack","PawnBlack2","PawnBlack3","PawnBlack4","PawnBlack5","PawnBlack6","PawnBlack7","PawnBlack8","KnightBlack","KnightBlack2","BishopBlack","BishopBlack2","RookBlack","RookBlack2"]
		randomNumber = randi_range(0, 13)

	if countPawn in [2, 4, 6, 8]: #if countPawn == 2 or countPawn == 4 or countPawn == 6 or countPawn == 8: C'est pareil que ça.
		while not findPiece:
			if randomPiece.size() == 0:
				break  # Exit if there are no more pieces to check

			var path = "/root/Game/ChessBoard/" + randomPiece[randomNumber]
			if has_node(path):
				var node = get_node(path)
				if node == null or node.get_node("Timer").visible:
					randomPiece.remove_at(randomNumber)
					if randomPiece.size() > 0:
						if countPawn == 2:
							randomNumber = randi_range(0, randomPiece.size() - 1)
						elif countPawn == 4:
							randomNumber = randi_range(0, randomPiece.size() - 1)
						elif countPawn == 6:
							randomNumber = randi_range(0, randomPiece.size() - 1)
						elif countPawn == 8:
							randomNumber = randi_range(0, randomPiece.size() - 1)
					else:
						break  # Break if there are no more pieces to check
				else:
					if playerID == OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id:
						rpc("deathPowerTargetPiece", randomPiece, randomNumber)
					findPiece = true

			if randomPiece.size() == 0:
				break  # Ensure we exit if no pieces are left

func deathPower(playerID, randomNumMax):
	var randomPiece = []
	var findPiece = false
	
	if randomNumMax == 7:
		randomPiece = ["PawnBlack","PawnBlack2","PawnBlack3","PawnBlack4","PawnBlack5","PawnBlack6","PawnBlack7","PawnBlack8"]
	elif randomNumMax == 9:
		randomPiece = ["PawnBlack","PawnBlack2","PawnBlack3","PawnBlack4","PawnBlack5","PawnBlack6","PawnBlack7","PawnBlack8","KnightBlack","KnightBlack2"]
	elif randomNumMax == 11:
		randomPiece = ["PawnBlack","PawnBlack2","PawnBlack3","PawnBlack4","PawnBlack5","PawnBlack6","PawnBlack7","PawnBlack8","KnightBlack","KnightBlack2","BishopBlack","BishopBlack2"]
	elif randomNumMax == 13:
		randomPiece = ["PawnBlack","PawnBlack2","PawnBlack3","PawnBlack4","PawnBlack5","PawnBlack6","PawnBlack7","PawnBlack8","KnightBlack","KnightBlack2","BishopBlack","BishopBlack2","RookBlack","RookBlack2"]
	
	var randomNumber = randi_range(0, randomNumMax)
	
	while not findPiece:
		if randomPiece.size() == 0:
			break  # Exit if there are no more pieces to check
		
		var path = "/root/Game/ChessBoard/" + randomPiece[randomNumber]

		if has_node(path):
			var node = get_node(path)
			if node == null or node.get_node("Timer").visible:
				randomPiece.remove_at(randomNumber)
				if randomPiece.size() > 0:
					randomNumber = randi_range(0, randomPiece.size() - 1)
				else:
					break  # Break if there are no more pieces to check
			else:
				if playerID == OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id:
					rpc("deathPowerTargetPiece", randomPiece, randomNumber)
				findPiece = true

		if randomPiece.size() == 0:
			break  # Ensure we exit if no pieces are left

func deathPowerKing(playerID):
	if usePowerKing <= 0:
		return

	var randomPiece = ["PawnBlack","PawnBlack2","PawnBlack3","PawnBlack4","PawnBlack5","PawnBlack6","PawnBlack7","PawnBlack8","KnightBlack","KnightBlack2","BishopBlack","BishopBlack2","RookBlack","RookBlack2","QueenBlack"]
	var randomNumber = randi_range(0, randomPiece.size() - 1)
	var findPiece = false

	while not findPiece:
		var path = "/root/Game/ChessBoard/" + randomPiece[randomNumber]
		
		if has_node(path):
			var node = get_node(path)
			if node == null or node.get_node("Timer").visible:
				randomPiece.remove_at(randomNumber)
				if randomPiece.size() > 0:
					randomNumber = randi_range(0, randomPiece.size() - 1)
				else:
					break  # Break if there are no more pieces to check
			else:
				if playerID == OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id:
					rpc("deathPowerTargetPiece", randomPiece, randomNumber)
				usePowerKing -= 1
				findPiece = true

		if randomPiece.size() == 0:
			break  # Ensure we exit if no pieces are left

@rpc("any_peer", "call_local") func deathPowerTargetPiece(randomPiece,randomNumber):
	var path = "/root/Game/ChessBoard/" + randomPiece[randomNumber]
	get_node(path).timer = 5
	get_node(path).get_node("Timer").visible = true
	get_node(path).get_node("Timer").text = "5"
	get_node(path).get_node("Timer").scale = Vector2(2,2)
