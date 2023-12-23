extends Sprite2D

var player_in_game := {}
var selectGod = false
var selectGodConfirm = false
var selectGodName = ""
var turnPlayer = "Player1"

# Called when the node enters the scene tree for the first time.
func _ready():
	game_start(GlobalValueMenu.players)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func game_start(players: Dictionary) -> void:
	player_in_game = players
	rpc('_do_game_setup', players)

@rpc("any_peer", "call_local") func _do_game_setup(players: Dictionary) -> void:
	get_tree().set_pause(true)
	
	get_node("Player1/DisplayGodSelect").texture = null
	get_node("Player1/DisplayPawnGodSelect").texture = null
	get_node("Player1/DisplayKnightGodSelect").texture = null
	get_node("Player1/DisplayBishopGodSelect").texture = null
	get_node("Player1/DisplayRookGodSelect").texture = null
	get_node("Player1/DisplayQueenGodSelect").texture = null
	get_node("Player1/DisplayKingGodSelect").texture = null
	
	get_node("Player2/DisplayGodSelect").texture = null
	get_node("Player2/DisplayPawnGodSelect").texture = null
	get_node("Player2/DisplayKnightGodSelect").texture = null
	get_node("Player2/DisplayBishopGodSelect").texture = null
	get_node("Player2/DisplayRookGodSelect").texture = null
	get_node("Player2/DisplayQueenGodSelect").texture = null
	get_node("Player2/DisplayKingGodSelect").texture = null
	
	if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1 :
		get_node("Player1/Username").text = player_in_game[player_in_game.keys()[0]]
		get_node("Player2/Username").text = player_in_game[player_in_game.keys()[1]]
		get_node("Username").text = "Au Joueur: " + player_in_game[player_in_game.keys()[0]] + " de choisir son dieu."
	else:
		get_node("Player1/Username").text = player_in_game[player_in_game.keys()[1]]
		get_node("Player2/Username").text = player_in_game[player_in_game.keys()[0]]
		get_node("Username").text = "Au Joueur: " + player_in_game[player_in_game.keys()[1]] + " de choisir son dieu."
	
	print("Joueur: ", Online.nakama_session.username, " player_in_game: ", player_in_game)
	
	rpc("_do_game_start")

@rpc("any_peer", "call_local") func _do_game_start() -> void:
	get_tree().set_pause(false)

func _on_button_goddess_of_teleportation_button_down():
	if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1 and turnPlayer == "Player1":
		rpc("selectGoddessOfTeleportation", "Player1")
	elif OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1 and turnPlayer == "Player2":
		rpc("selectGoddessOfTeleportation", "Player2")
	selectGod = true

func _on_button_goddess_of_teleportation_mouse_entered():
	if selectGod == false:
		if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1 and turnPlayer == "Player1":
			get_node("Player1/DisplayGodSelect").texture = load("res://Image/Gods/GoddessOfTeleportation/Déesse de la Téléportation IA - Couleur.png")
			get_node("Player1/DisplayPawnGodSelect").texture = load("res://Image/Gods/GoddessOfTeleportation/Pieces/Base pièce doubler - Pion.png")
			get_node("Player1/DisplayKnightGodSelect").texture = load("res://Image/Gods/GoddessOfTeleportation/Pieces/Base pièce doubler - Cavalier.png")
			get_node("Player1/DisplayBishopGodSelect").texture = load("res://Image/Gods/GoddessOfTeleportation/Pieces/Base pièce doubler - Fou.png")
			get_node("Player1/DisplayRookGodSelect").texture = load("res://Image/Gods/GoddessOfTeleportation/Pieces/Base pièce doubler - Tour.png")
			get_node("Player1/DisplayQueenGodSelect").texture = load("res://Image/Gods/GoddessOfTeleportation/Pieces/Base pièce doubler - Reine.png")
			get_node("Player1/DisplayKingGodSelect").texture = load("res://Image/Gods/GoddessOfTeleportation/Pieces/Base pièce doubler - Roi.png")
		elif OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1 and turnPlayer == "Player2":
			get_node("Player2/DisplayGodSelect").texture = load("res://Image/Gods/GoddessOfTeleportation/Déesse de la Téléportation IA - Couleur.png")
			get_node("Player2/DisplayPawnGodSelect").texture = load("res://Image/Gods/GoddessOfTeleportation/Pieces/Base pièce doubler - Pion.png")
			get_node("Player2/DisplayKnightGodSelect").texture = load("res://Image/Gods/GoddessOfTeleportation/Pieces/Base pièce doubler - Cavalier.png")
			get_node("Player2/DisplayBishopGodSelect").texture = load("res://Image/Gods/GoddessOfTeleportation/Pieces/Base pièce doubler - Fou.png")
			get_node("Player2/DisplayRookGodSelect").texture = load("res://Image/Gods/GoddessOfTeleportation/Pieces/Base pièce doubler - Tour.png")
			get_node("Player2/DisplayQueenGodSelect").texture = load("res://Image/Gods/GoddessOfTeleportation/Pieces/Base pièce doubler - Reine.png")
			get_node("Player2/DisplayKingGodSelect").texture = load("res://Image/Gods/GoddessOfTeleportation/Pieces/Base pièce doubler - Roi.png")

func _on_button_goddess_of_teleportation_mouse_exited():
	if selectGod == false:
		if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1 and turnPlayer == "Player1":
			get_node("Player1/DisplayGodSelect").texture = null
			get_node("Player1/DisplayPawnGodSelect").texture = null
			get_node("Player1/DisplayKnightGodSelect").texture = null
			get_node("Player1/DisplayBishopGodSelect").texture = null
			get_node("Player1/DisplayRookGodSelect").texture = null
			get_node("Player1/DisplayQueenGodSelect").texture = null
			get_node("Player1/DisplayKingGodSelect").texture = null
		elif OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1 and turnPlayer == "Player2":
			get_node("Player2/DisplayGodSelect").texture = null
			get_node("Player2/DisplayPawnGodSelect").texture = null
			get_node("Player2/DisplayKnightGodSelect").texture = null
			get_node("Player2/DisplayBishopGodSelect").texture = null
			get_node("Player2/DisplayRookGodSelect").texture = null
			get_node("Player2/DisplayQueenGodSelect").texture = null
			get_node("Player2/DisplayKingGodSelect").texture = null

@rpc("any_peer", "call_local") func selectGoddessOfTeleportation(player) -> void:
	get_node(player + "/DisplayGodSelect").texture = load("res://Image/Gods/GoddessOfTeleportation/Déesse de la Téléportation IA - Couleur.png")
	get_node(player + "/DisplayPawnGodSelect").texture = load("res://Image/Gods/GoddessOfTeleportation/Pieces/Base pièce doubler - Pion.png")
	get_node(player + "/DisplayKnightGodSelect").texture = load("res://Image/Gods/GoddessOfTeleportation/Pieces/Base pièce doubler - Cavalier.png")
	get_node(player + "/DisplayBishopGodSelect").texture = load("res://Image/Gods/GoddessOfTeleportation/Pieces/Base pièce doubler - Fou.png")
	get_node(player + "/DisplayRookGodSelect").texture = load("res://Image/Gods/GoddessOfTeleportation/Pieces/Base pièce doubler - Tour.png")
	get_node(player + "/DisplayQueenGodSelect").texture = load("res://Image/Gods/GoddessOfTeleportation/Pieces/Base pièce doubler - Reine.png")
	get_node(player + "/DisplayKingGodSelect").texture = load("res://Image/Gods/GoddessOfTeleportation/Pieces/Base pièce doubler - Roi.png")
	selectGodName = "GoddessOfTeleportation"

#########################################################


func _on_button_god_of_death_button_down():
	if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1 and turnPlayer == "Player1":
		rpc("selectGodOfDeath", "Player1")
	elif OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1 and turnPlayer == "Player2":
		rpc("selectGodOfDeath", "Player2")
	selectGod = true

func _on_button_god_of_death_mouse_entered():
	if selectGod == false:
		if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1 and turnPlayer == "Player1":
			get_node("Player1/DisplayGodSelect").texture = load("res://Image/Gods/GodOfDeath/Dieu de la Mort IA - Couleur.png")
			get_node("Player1/DisplayPawnGodSelect").texture = load("res://Image/Gods/GodOfDeath/Pieces/Base pièce doubler - Pion.png")
			get_node("Player1/DisplayKnightGodSelect").texture = load("res://Image/Gods/GodOfDeath/Pieces/Base pièce doubler - Cavalier.png")
			get_node("Player1/DisplayBishopGodSelect").texture = load("res://Image/Gods/GodOfDeath/Pieces/Base pièce doubler - Fou.png")
			get_node("Player1/DisplayRookGodSelect").texture = load("res://Image/Gods/GodOfDeath/Pieces/Base pièce doubler - Tour.png")
			get_node("Player1/DisplayQueenGodSelect").texture = load("res://Image/Gods/GodOfDeath/Pieces/Base pièce doubler - Reine.png")
			get_node("Player1/DisplayKingGodSelect").texture = load("res://Image/Gods/GodOfDeath/Pieces/Base pièce doubler - Roi.png")
		elif OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1 and turnPlayer == "Player2":
			get_node("Player2/DisplayGodSelect").texture = load("res://Image/Gods/GodOfDeath/Dieu de la Mort IA - Couleur.png")
			get_node("Player2/DisplayPawnGodSelect").texture = load("res://Image/Gods/GodOfDeath/Pieces/Base pièce doubler - Pion.png")
			get_node("Player2/DisplayKnightGodSelect").texture = load("res://Image/Gods/GodOfDeath/Pieces/Base pièce doubler - Cavalier.png")
			get_node("Player2/DisplayBishopGodSelect").texture = load("res://Image/Gods/GodOfDeath/Pieces/Base pièce doubler - Fou.png")
			get_node("Player2/DisplayRookGodSelect").texture = load("res://Image/Gods/GodOfDeath/Pieces/Base pièce doubler - Tour.png")
			get_node("Player2/DisplayQueenGodSelect").texture = load("res://Image/Gods/GodOfDeath/Pieces/Base pièce doubler - Reine.png")
			get_node("Player2/DisplayKingGodSelect").texture = load("res://Image/Gods/GodOfDeath/Pieces/Base pièce doubler - Roi.png")

func _on_button_god_of_death_mouse_exited():
	if selectGod == false:
		if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1 and turnPlayer == "Player1":
			get_node("Player1/DisplayGodSelect").texture = null
			get_node("Player1/DisplayPawnGodSelect").texture = null
			get_node("Player1/DisplayKnightGodSelect").texture = null
			get_node("Player1/DisplayBishopGodSelect").texture = null
			get_node("Player1/DisplayRookGodSelect").texture = null
			get_node("Player1/DisplayQueenGodSelect").texture = null
			get_node("Player1/DisplayKingGodSelect").texture = null
		elif OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1 and turnPlayer == "Player2":
			get_node("Player2/DisplayGodSelect").texture = null
			get_node("Player2/DisplayPawnGodSelect").texture = null
			get_node("Player2/DisplayKnightGodSelect").texture = null
			get_node("Player2/DisplayBishopGodSelect").texture = null
			get_node("Player2/DisplayRookGodSelect").texture = null
			get_node("Player2/DisplayQueenGodSelect").texture = null
			get_node("Player2/DisplayKingGodSelect").texture = null

@rpc("any_peer", "call_local") func selectGodOfDeath(player) -> void:
	get_node(player + "/DisplayGodSelect").texture = load("res://Image/Gods/GodOfDeath/Dieu de la Mort IA - Couleur.png")
	get_node(player + "/DisplayPawnGodSelect").texture = load("res://Image/Gods/GodOfDeath/Pieces/Base pièce doubler - Pion.png")
	get_node(player + "/DisplayKnightGodSelect").texture = load("res://Image/Gods/GodOfDeath/Pieces/Base pièce doubler - Cavalier.png")
	get_node(player + "/DisplayBishopGodSelect").texture = load("res://Image/Gods/GodOfDeath/Pieces/Base pièce doubler - Fou.png")
	get_node(player + "/DisplayRookGodSelect").texture = load("res://Image/Gods/GodOfDeath/Pieces/Base pièce doubler - Tour.png")
	get_node(player + "/DisplayQueenGodSelect").texture = load("res://Image/Gods/GodOfDeath/Pieces/Base pièce doubler - Reine.png")
	get_node(player + "/DisplayKingGodSelect").texture = load("res://Image/Gods/GodOfDeath/Pieces/Base pièce doubler - Roi.png")
	selectGodName = "GodOfDeath"

func _on_button_confirm_button_down():
	if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1\
	and turnPlayer == "Player1" and selectGod == true:
		selectGodConfirm = true
		rpc("selectGodConfirmed")
	elif OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id != 1\
	and turnPlayer == "Player2" and selectGod == true:
		selectGodConfirm = true
		rpc("selectGodConfirmed")

@rpc("any_peer", "call_local") func selectGodConfirmed() -> void:
	if OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id == 1 and turnPlayer == "Player1":
		get_node("Username").text = "Au Joueur: " + player_in_game[player_in_game.keys()[1]] + " de choisir son dieu."
	else:
		get_node("Username").text = "Au Joueur: " + player_in_game[player_in_game.keys()[0]] + " de choisir son dieu."
			
	if turnPlayer == "Player1":
		turnPlayer = "Player2"
		GlobalValueMenu.godSelectPlayer1 = selectGodName
		print("Joueur: ", Online.nakama_session.username, " GlobalValueMenu.godSelectPlayer1: ", GlobalValueMenu.godSelectPlayer1)
	elif turnPlayer == "Player2":
		GlobalValueMenu.godSelectPlayer2 = selectGodName
		print("Joueur: ", Online.nakama_session.username, " GlobalValueMenu.godSelectPlayer2: ", GlobalValueMenu.godSelectPlayer2)
		get_tree().change_scene_to_file("res://Scene/Game/Game.tscn")
