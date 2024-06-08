extends Node

var randomPiece = ["PawnBlack","PawnBlack2","PawnBlack3","PawnBlack4","PawnBlack5","PawnBlack6","PawnBlack7","PawnBlack8","KnightBlack","KnightBlack2","BishopBlack","BishopBlack2","RookBlack","RookBlack2"]
var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#Powers of God of Death

func deathPowerPawn(playerID, chessBoard):
	var countPawn = 8
	var randomNumber = randi_range(0,7)
	var findPiece = false
	var countWhile = 0
	
	for i in range(2,10):
		for j in range(2,10):
			if chessBoard[i][j].begins_with("PawnWhite"):
				countPawn -= 1
	
	if countPawn == 4:
		randomNumber = randi_range(0,9)
	elif countPawn == 6:
		randomNumber = randi_range(0,11)
	elif countPawn == 8:
		randomNumber = randi_range(0,13)
	
	if countPawn == 2 or countPawn == 4 or countPawn == 6 or countPawn == 8:
		while findPiece == false and countWhile < 1000:
			if has_node("/root/Game/ChessBoard/" + randomPiece[randomNumber]) == true:
				if get_node("/root/Game/ChessBoard/" + randomPiece[randomNumber]) == null\
				or get_node("/root/Game/ChessBoard/" + randomPiece[randomNumber]).get_node("Timer").visible == true:
					if countPawn == 2:
						randomNumber = randi_range(0,7)
					elif countPawn == 4:
						randomNumber = randi_range(0,9)
					elif countPawn == 6:
						randomNumber = randi_range(0,11)
					elif countPawn == 8:
						randomNumber = randi_range(0,13)
				else:
					if playerID == OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id:
						rpc("deathPowerTargetPiece",randomPiece,randomNumber)
					findPiece = true
			elif has_node("/root/Game/ChessBoard/" + randomPiece[randomNumber]) == false:
				countWhile = countWhile + 1
				continue
				

func deathPower(playerID,randomNumMax):
	print("In deathPower")
	var randomNumber = randi_range(0,randomNumMax)
	var findPiece = false
	while findPiece == false and count < 1000:
		if has_node("/root/Game/ChessBoard/" + randomPiece[randomNumber]) == true:
			if get_node("/root/Game/ChessBoard/" + randomPiece[randomNumber]) == null\
			or get_node("/root/Game/ChessBoard/" + randomPiece[randomNumber]).get_node("Timer").visible == true:
				randomNumber = randi_range(0,randomNumMax)
			else:
				if playerID == OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id:
					rpc("deathPowerTargetPiece",randomPiece,randomNumber)
				findPiece = true
		elif has_node("/root/Game/ChessBoard/" + randomPiece[randomNumber]) == false:
			count = count + 1
			continue

@rpc("any_peer", "call_local") func deathPowerTargetPiece(randomPiece,randomNumber):
	print("In deathPowerTargetPiece")
	get_node("/root/Game/ChessBoard/" + randomPiece[randomNumber]).get_node("Timer").visible = true
	get_node("/root/Game/ChessBoard/" + randomPiece[randomNumber]).timer = 5
	get_node("/root/Game/ChessBoard/" + randomPiece[randomNumber]).get_node("Timer").text = "5"
	get_node("/root/Game/ChessBoard/" + randomPiece[randomNumber]).get_node("Timer").scale = Vector2(1.5,1.5)
