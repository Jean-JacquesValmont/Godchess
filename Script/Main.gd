extends Node2D

@onready var ready_screen = $UILayer/Screen/ReadyScreen

var players := {}
var players_ready := {}
# Called when the node enters the scene tree for the first time.
func _ready():
	$UILayer/Screen/ReadyScreen.connect("ready_pressed", Callable(self, "_on_ready_screen_ready_pressed"))
#####
# UI callbacks
#####

func _on_connection_screen_hidden():
	$UILayer/Screen/MatchScreen.show()

func _on_match_screen_hidden(info):
	print("info in _on_match_screen_hidden:", info)
	$UILayer/Screen/ReadyScreen.show()
	#Permet d'appeller une fonction d'un script depuis un autre script
	$UILayer/Screen/ReadyScreen.callv("_show_screen", [info])
	
func _on_ready_screen_back_pressed():
	OnlineMatch.leave()
	$UILayer/Screen/MatchScreen.show()

func _on_ready_screen_ready_pressed():
	rpc("player_ready", OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id)

@rpc("any_peer", "call_local") func player_ready(peer_id: int) -> void:
	ready_screen.set_status(peer_id, "READY!")

##	if get_tree().is_network_server() and not players_ready.has(peer_id):
#	if OnlineMatch._nakama_multiplayer_bridge._multiplayer_peer._is_server():
	players_ready[peer_id] = true
	if players_ready.size() == OnlineMatch.players.size():
		if OnlineMatch.match_state != OnlineMatch.MatchState.PLAYING:
			OnlineMatch.start_playing()
		start_game()

func start_game() -> void:
	print("Start Game")
	players = OnlineMatch.get_player_names_by_peer_id()
	$Game.game_start(players)

func _on_game_game_started() -> void:
	print("Hide UILayer")
	$UILayer.hide()

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
