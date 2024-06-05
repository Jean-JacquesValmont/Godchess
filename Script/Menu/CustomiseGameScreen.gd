extends Sprite2D

var PeerStatus = preload("res://Scene/Menu/PeerStatus.tscn");

@onready var buttonReady := $Options/ButtonReady
@onready var buttonBack := $Room/ButtonQuitRoom
@onready var matchIDLabel := $Room/MatchIDText
@onready var statusContainer := $Room/StatusContainer

signal ready_pressed()

func _ready() -> void:
	clear_players()

	OnlineMatch.connect("player_joined", Callable(self, "_on_OnlineMatch_player_joined"))
	OnlineMatch.connect("player_left", Callable(self, "_on_OnlineMatch_player_left"))
	OnlineMatch.connect("match_ready", Callable(self, "_on_OnlineMatch_match_ready"))
	OnlineMatch.connect("match_not_ready", Callable(self, "_on_OnlineMatch_match_not_ready"))

func _process(delta):
	pass
		
func _show_screen(info: Dictionary = {}) -> void:
	var players: Dictionary = info.get("players", {})
	var match_id: String = info.get("match_id", '')
	var clear: bool = info.get("clear", false)

	if players.size() > 0 or clear:
		clear_players()

	for peer_id in players:
		add_player(peer_id, players[peer_id]['username'])
	
	matchIDLabel.text = match_id
	buttonReady.grab_focus()

func clear_players() -> void:
	for child in statusContainer.get_children():
		statusContainer.remove_child(child)
		child.queue_free()
	buttonReady.disabled = true

func add_player(peer_id: int, username: String) -> void:
	if not statusContainer.has_node(str(peer_id)):
		var status = PeerStatus.instantiate()
		statusContainer.add_child(status)
		status.initialize(username)
		status.name = str(peer_id)

func remove_player(peer_id: int) -> void:
	var status = statusContainer.get_node(str(peer_id))
	if status:
		status.queue_free()

func set_status(peer_id: int, status: String) -> void:
	var status_node = statusContainer.get_node(str(peer_id))
	if status_node:
		status_node.set_status(status)

func get_status(peer_id: int) -> String:
	var status_node = statusContainer.get_node(str(peer_id))
	if status_node:
		return status_node.status
	return ''

func reset_status(status: String) -> void:
	for child in statusContainer.get_children():
		child.set_status(status)

func set_ready_button_enabled(enabled: bool = true) -> void:
	buttonReady.disabled = !enabled
	if enabled:
		buttonReady.grab_focus()

func _on_button_copy_match_id_button_down():
	DisplayServer.clipboard_set(matchIDLabel.text)

func _on_button_ready_button_down():
	emit_signal("ready_pressed")

func _on_button_quit_room_button_down():
	OnlineMatch.leave()
	self.hide()
	get_node("/root/Menu/Background/PlayScreen").show()

#####
# OnlineMatch callbacks:
#####

func _on_OnlineMatch_player_joined(player) -> void:
	add_player(player.peer_id, player.username)

func _on_OnlineMatch_player_left(player) -> void:
	remove_player(player.peer_id)

func _on_OnlineMatch_match_ready(_players: Dictionary) -> void:
	set_ready_button_enabled(true)

func _on_OnlineMatch_match_not_ready() -> void:
	set_ready_button_enabled(false)





