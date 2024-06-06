extends Node2D

@onready var customiseGameScreen = $Background/CustomiseGameScreen

var players := {}
var players_ready := {}

# Called when the node enters the scene tree for the first time.
func _ready():
	customiseGameScreen.connect("ready_pressed", Callable(self, "_on_customise_game_screen_ready_pressed"))
	customiseGameScreen.connect("start_pressed", Callable(self, "_on_customise_game_screen_start_pressed"))	

#Code matchmaking part##########################################################
func _on_customise_game_screen_ready_pressed():
	rpc("player_ready", OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id)

func _on_customise_game_screen_start_pressed():
	rpc("press_start_game")
	
@rpc("any_peer", "call_local") func player_ready(peer_id: int) -> void:
	if customiseGameScreen.get_status(peer_id) == "Not ready":
		customiseGameScreen.set_status(peer_id, "READY!")

	##	if get_tree().is_network_server() and not players_ready.has(peer_id):
	#	if get_tree().network_server:
		players_ready[peer_id] = true
	elif customiseGameScreen.get_status(peer_id) == "READY!":
		customiseGameScreen.set_status(peer_id, "Not ready")
		players_ready[peer_id] = false
		
@rpc("any_peer", "call_local") func press_start_game() -> void:
	var allPlayerIsReady = true
	for key in players_ready.keys():
		var value = players_ready[key]
		if value == false:
			allPlayerIsReady = false
			
	if players_ready.size() == OnlineMatch.players.size() and allPlayerIsReady == true:
		if OnlineMatch.match_state != OnlineMatch.MatchState.PLAYING:
			OnlineMatch.start_playing()
		start_game()

#Code game part##########################################################
func start_game() -> void:
	GlobalValueMenu.players = OnlineMatch.get_player_names_by_peer_id()
	get_tree().change_scene_to_file("res://Scene/Game/SelectGodsScreen.tscn")

#func _on_game_game_started() -> void:
#	print("Hide Background")
#	$Background.hide()

#func stop_game() -> void:
#	print("function stop_game")
#	$Game.hide()
#	OnlineMatch.leave()
#
#	$UILayer.show()
#	$UILayer/Screen/ReadyScreen.hide()
#	$UILayer/Screen/MatchScreen.show()
#	players.clear()
#	players_ready.clear()
#
##	$Game.stop_game()

func _on_game_game_stop():
	print("function _on_Game_game_stop")
#	stop_game()


