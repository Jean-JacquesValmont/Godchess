extends Control

@onready var displayPieceNode = $DisplayPiece
@onready var displayPieceAttackWhiteNode = $DisplayAttackWhite
@onready var displayPieceAttackBlackNode = $DisplayAttackBlack
var chessBoard = GlobalValueChessGame.chessBoard
var chessBoardReverse = []
var attackWhite = GlobalValueChessGame.attackPieceWhiteOnTheChessboard
var attackWhiteReverse = []
var attackBlack = GlobalValueChessGame.attackPieceBlackOnTheChessboard
var attackBlackReverse = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("open_display_piece"):
		if displayPieceNode.visible == false:
			if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
				createNodeText(chessBoard, displayPieceNode)
			elif OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1:
				chessBoardReverse = reverseChessBoard(chessBoard)
				createNodeText(chessBoardReverse, displayPieceNode)
			displayPieceNode.visible = true
			displayPieceAttackWhiteNode.visible = false
			displayPieceAttackBlackNode.visible = false
		elif displayPieceNode.visible == true:
			displayPieceNode.visible = false
			displayPieceAttackWhiteNode.visible = false
			displayPieceAttackBlackNode.visible = false
			
	if event.is_action_pressed("open_display_attack_white"):
		if displayPieceAttackWhiteNode.visible == false:
			if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
				createNodeText(attackWhite, displayPieceAttackWhiteNode)
			elif OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1:
				attackWhiteReverse = reverseChessBoard(attackWhite)
				createNodeText(attackWhite, displayPieceAttackWhiteNode)
			displayPieceNode.visible = false
			displayPieceAttackWhiteNode.visible = true
			displayPieceAttackBlackNode.visible = false
		elif displayPieceAttackWhiteNode.visible == true:
			displayPieceNode.visible = false
			displayPieceAttackWhiteNode.visible = false
			displayPieceAttackBlackNode.visible = false
			
	if event.is_action_pressed("open_display_attack_black"):
		if displayPieceAttackBlackNode.visible == false:
			if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
				createNodeText(attackBlack,displayPieceAttackBlackNode)
			elif OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1:
				attackBlackReverse = reverseChessBoard(attackBlack)
				createNodeText(attackBlack,displayPieceAttackBlackNode)
			displayPieceNode.visible = false
			displayPieceAttackWhiteNode.visible = false
			displayPieceAttackBlackNode.visible = true
		elif displayPieceAttackBlackNode.visible == true:
			displayPieceNode.visible = false
			displayPieceAttackWhiteNode.visible = false
			displayPieceAttackBlackNode.visible = false

func createNodeText(chessBoardChoice,displayNode):
	for i in range(2,10):
		for j in range(2,10):
			var textNode = Label.new()
			textNode.text = str(chessBoardChoice[i][j])
			textNode.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			textNode.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
			textNode.position.x = 50 + j*100 - 200
			textNode.position.y = 50 + i*100 - 200
			displayNode.add_child(textNode)

func reverseChessBoard(chessBoard):
	var chessBoardSaved = []
	# Créer une copie du tableau sans lien avec l'original
	chessBoardSaved = chessBoard.duplicate(true) #Le true permet de faire une copie du tableau qui n'est pas liée à l'original
	
	# Inverser chaque ligne du tableau
	for i in range(chessBoardSaved.size()):
		chessBoardSaved[i].reverse()

	# Inverser l'ordre des lignes dans le tableau
	chessBoardSaved.reverse()
	
	return chessBoardSaved

