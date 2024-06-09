extends Sprite2D

var player_in_game := {}
var godSelectPlayer1 = ""
var godSelectPlayer2 = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	GlobalValueMenu.menuOpen = false
	player_in_game = GlobalValueMenu.players
	godSelectPlayer1 = GlobalValueMenu.godSelectPlayer1
	godSelectPlayer2 = GlobalValueMenu.godSelectPlayer2
	print("GlobalValueMenu.godSelectPlayer1: ", GlobalValueMenu.godSelectPlayer1)
	print("GlobalValueMenu.godSelectPlayer2: ", GlobalValueMenu.godSelectPlayer2)
	
	if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
		self.texture = load("res://Image/Game/ChessBoardSideWhite.png")
		get_node("Player1/Username").text = player_in_game[player_in_game.keys()[0]]
		get_node("Player2/Username").text = player_in_game[player_in_game.keys()[1]]
		get_node("Player1/GodSelect").texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer1 + "/ChessBoardImageGod.png")
		get_node("Player2/GodSelect").texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer2 + "/ChessBoardImageGod.png")
	else:
		self.texture = load("res://Image/Game/ChessBoardSideBlack.png")
		get_node("Player1/Username").text = player_in_game[player_in_game.keys()[0]]
		get_node("Player2/Username").text = player_in_game[player_in_game.keys()[1]]
		get_node("Player1/GodSelect").texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer2 + "/ChessBoardImageGod.png")
		get_node("Player2/GodSelect").texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer1 + "/ChessBoardImageGod.png")
	
	#Sprite pieces player 1:
	get_node("ChessBoard").get_child(0).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer1 + "/Pieces/Base pièce doubler - Pion.png")
	get_node("ChessBoard").get_child(1).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer1 + "/Pieces/Base pièce doubler - Pion.png")
	get_node("ChessBoard").get_child(2).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer1 + "/Pieces/Base pièce doubler - Pion.png")
	get_node("ChessBoard").get_child(3).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer1 + "/Pieces/Base pièce doubler - Pion.png")
	get_node("ChessBoard").get_child(4).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer1 + "/Pieces/Base pièce doubler - Pion.png")
	get_node("ChessBoard").get_child(5).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer1 + "/Pieces/Base pièce doubler - Pion.png")
	get_node("ChessBoard").get_child(6).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer1 + "/Pieces/Base pièce doubler - Pion.png")
	get_node("ChessBoard").get_child(7).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer1 + "/Pieces/Base pièce doubler - Pion.png")
	get_node("ChessBoard").get_child(8).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer1 + "/Pieces/Base pièce doubler - Cavalier.png")
	get_node("ChessBoard").get_child(9).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer1 + "/Pieces/Base pièce doubler - Cavalier.png")
	get_node("ChessBoard").get_child(10).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer1 + "/Pieces/Base pièce doubler - Fou.png")
	get_node("ChessBoard").get_child(11).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer1 + "/Pieces/Base pièce doubler - Fou.png")
	get_node("ChessBoard").get_child(12).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer1 + "/Pieces/Base pièce doubler - Tour.png")
	get_node("ChessBoard").get_child(13).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer1 + "/Pieces/Base pièce doubler - Tour.png")
	get_node("ChessBoard").get_child(14).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer1 + "/Pieces/Base pièce doubler - Reine.png")
	get_node("ChessBoard").get_child(15).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer1 + "/Pieces/Base pièce doubler - Roi.png")
	
	#Sprite pieces player 2:
	get_node("ChessBoard").get_child(16).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer2 + "/Pieces/Base pièce doubler - Pion.png")
	get_node("ChessBoard").get_child(17).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer2 + "/Pieces/Base pièce doubler - Pion.png")
	get_node("ChessBoard").get_child(18).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer2 + "/Pieces/Base pièce doubler - Pion.png")
	get_node("ChessBoard").get_child(19).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer2 + "/Pieces/Base pièce doubler - Pion.png")
	get_node("ChessBoard").get_child(20).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer2 + "/Pieces/Base pièce doubler - Pion.png")
	get_node("ChessBoard").get_child(21).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer2 + "/Pieces/Base pièce doubler - Pion.png")
	get_node("ChessBoard").get_child(22).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer2 + "/Pieces/Base pièce doubler - Pion.png")
	get_node("ChessBoard").get_child(23).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer2 + "/Pieces/Base pièce doubler - Pion.png")
	get_node("ChessBoard").get_child(24).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer2 + "/Pieces/Base pièce doubler - Cavalier.png")
	get_node("ChessBoard").get_child(25).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer2 + "/Pieces/Base pièce doubler - Cavalier.png")
	get_node("ChessBoard").get_child(26).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer2 + "/Pieces/Base pièce doubler - Fou.png")
	get_node("ChessBoard").get_child(27).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer2 + "/Pieces/Base pièce doubler - Fou.png")
	get_node("ChessBoard").get_child(28).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer2 + "/Pieces/Base pièce doubler - Tour.png")
	get_node("ChessBoard").get_child(29).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer2 + "/Pieces/Base pièce doubler - Tour.png")
	get_node("ChessBoard").get_child(30).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer2 + "/Pieces/Base pièce doubler - Reine.png")
	get_node("ChessBoard").get_child(31).texture = load("res://Image/Gods/" + GlobalValueMenu.godSelectPlayer2 + "/Pieces/Base pièce doubler - Roi.png")
	
	for i in range(get_node("ChessBoard").get_child_count()):
		get_node("ChessBoard").get_child(i).scale = Vector2(0.5, 0.5)
	
	GlobalValueChessGame.gameLaunch = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	checkPlayerDisconnected()
	
	#Display turn player
	if GlobalValueChessGame.turnWhite == true and OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
		get_node("TurnPlayer").set_text("A votre tour de jouer")
	elif GlobalValueChessGame.turnWhite == false and OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
		get_node("TurnPlayer").set_text("Au tour de l'adversaire")
	
	if GlobalValueChessGame.turnWhite == false and OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1:
		get_node("TurnPlayer").set_text("A votre tour de jouer")
	elif GlobalValueChessGame.turnWhite == true and OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1:
		get_node("TurnPlayer").set_text("Au tour de l'adversaire")
	
	#################################################################
	#Display checkmate 
	
	if GlobalValueChessGame.checkWhite == true:
		if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
			get_node("Player1/DisplayCheckmate").set_text("Echec")
		else:
			get_node("Player2/DisplayCheckmate").set_text("Echec")
	elif GlobalValueChessGame.checkWhite == false:
		if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
			get_node("Player1/DisplayCheckmate").set_text("")
		else:
			get_node("Player2/DisplayCheckmate").set_text("")
	
	if GlobalValueChessGame.checkBlack == true:
		if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
			get_node("Player2/DisplayCheckmate").set_text("Echec")
		else:
			get_node("Player1/DisplayCheckmate").set_text("Echec")
	elif GlobalValueChessGame.checkBlack == false:
		if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
			get_node("Player2/DisplayCheckmate").set_text("")
		else:
			get_node("Player1/DisplayCheckmate").set_text("")
	
	if GlobalValueChessGame.stalemate == true:
		get_node("Player1/DisplayCheckmate").set_text("Pat")
		get_node("Player2/DisplayCheckmate").set_text("Pat")
	
	if GlobalValueChessGame.checkmateWhite == true and GlobalValueChessGame.checkmate == true:
		if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
			get_node("Player1/DisplayCheckmate").set_text("Echec et Mat")
		else:
			get_node("Player2/DisplayCheckmate").set_text("Echec et Mat")
	
	if GlobalValueChessGame.checkmateBlack == true and GlobalValueChessGame.checkmate == true:
		if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1:
			get_node("Player2/DisplayCheckmate").set_text("Echec et Mat")
		else:
			get_node("Player1/DisplayCheckmate").set_text("Echec et Mat")

func checkPlayerDisconnected():
	if OnlineMatch.__players.size() < 2 and get_node("PlayerLeftGame").visible != true:
		get_node("PlayerLeftGame/TextPlayerLeftGame").text = "L'adversaire c'est déconnecté."
		get_node("PlayerLeftGame").show()
		GlobalValueMenu.menuOpen = true

func variableGlobalReset():
	#	GlobalValueChessGame.startWhite = true
	GlobalValueChessGame.gameLaunch = false
	GlobalValueChessGame.initialisationDone = false
	GlobalValueChessGame.oneMoveCase = 100
	GlobalValueChessGame.turnWhite = true
	GlobalValueChessGame.updateOfThePartsAttack = false
	GlobalValueChessGame.directionOfAttack = "Aucune"
	GlobalValueChessGame.checkWhite = false
	GlobalValueChessGame.checkBlack = false
	GlobalValueChessGame.pieceProtectTheKing = false
	GlobalValueChessGame.threatened = false
	GlobalValueChessGame.stalemate = false
	GlobalValueChessGame.checkmateWhite = false
	GlobalValueChessGame.checkmateBlack = false
	GlobalValueChessGame.checkmate = false

func _on_button_game_menu_button_down():
	if get_node("GameMenu").visible == false:
		get_node("GameMenu").show()
		get_node("GameMenu/ButtonResume").disabled = false
		get_node("GameMenu/ButtonOption").disabled = false
		get_node("GameMenu/ButtonAbandon").disabled = false
		GlobalValueMenu.menuOpen = true

func _on_button_resume_button_down():
	if get_node("GameMenu").visible == true:
		get_node("GameMenu").hide()
		get_node("GameMenu/ButtonResume").disabled = true
		get_node("GameMenu/ButtonOption").disabled = true
		get_node("GameMenu/ButtonAbandon").disabled = true
		GlobalValueMenu.menuOpen = false

func _on_button_option_button_down():
	pass # Replace with function body.

func _on_button_abandon_button_down():
	get_node("ModalConfirmAbandon").show()
	
func _on_button_cancel_button_down():
	get_node("ModalConfirmAbandon").hide()

func _on_button_confirm_abandon_button_down():
	rpc("playerAbandons")
	get_tree().change_scene_to_file("res://Scene/Menu/Menu.tscn")
	OnlineMatch.leave()
	#Reset variables global
	variableGlobalReset()
	
	#Reset variables power global
	GodOfDeathPower.usePowerKing = 3

@rpc("any_peer","call_remote") func playerAbandons():
	get_node("PlayerLeftGame").show()
	GlobalValueMenu.menuOpen = true

func _on_button_left_game_button_down():
	get_tree().change_scene_to_file("res://Scene/Menu/Menu.tscn")
	OnlineMatch.leave()
	#Reset variables global
	variableGlobalReset()
	
	#Reset variables power global
	GodOfDeathPower.usePowerKing = 3
