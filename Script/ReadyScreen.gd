extends Control

var PeerStatus = preload("res://Scene/PeerStatus.tscn");

@onready var ready_button := $Panel/ReadyButton
@onready var back_button := $Panel/BackButton
@onready var match_id_container := $Panel/MatchIDContainer
@onready var match_id_label := $Panel/MatchIDContainer/MatchIDText
@onready var status_container := $Panel/StatusContainer

@onready var display_timer_disconneted := $Panel/DisplayTimerDisconneted
var timer_running: bool = false
var timer: float = 10
var stopSearchUser = false

signal ready_pressed()
signal back_pressed()
signal peer_connected()

func _ready() -> void:
	clear_players()

	OnlineMatch.connect("player_joined", Callable(self, "_on_OnlineMatch_player_joined"))
	OnlineMatch.connect("player_left", Callable(self, "_on_OnlineMatch_player_left"))
	OnlineMatch.connect("match_ready", Callable(self, "_on_OnlineMatch_match_ready"))
	OnlineMatch.connect("match_not_ready", Callable(self, "_on_OnlineMatch_match_not_ready"))

func _process(delta):
			
	if self.visible == true and back_button.visible == false:
		display_timer_disconneted.visible = true
		timer -= delta
		update_timer_label()

func update_timer_label() -> void:
	var total_seconds = float(timer)
	var minutes = total_seconds / 60
	var seconds = total_seconds % 60
	display_timer_disconneted.text = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)
	if timer <= 0 :
		display_timer_disconneted.visible = false
		timer = 10
		self.hide()
		emit_signal("back_pressed")
		
func _show_screen(info: Dictionary = {}) -> void:
	var players: Dictionary = info.get("players", {})
	var match_id: String = info.get("match_id", '')
	var clear: bool = info.get("clear", false)

	if players.size() > 0 or clear:
		clear_players()

	for peer_id in players:
		add_player(peer_id, players[peer_id]['username'])

	if match_id:
		match_id_container.visible = true
		match_id_label.text = match_id
		back_button.visible = true
	else:
		match_id_container.visible = false
		back_button.visible = false

	ready_button.grab_focus()

func clear_players() -> void:
	for child in status_container.get_children():
		status_container.remove_child(child)
		child.queue_free()
	ready_button.disabled = true

func hide_match_id() -> void:
	match_id_container.visible = false

func add_player(peer_id: int, username: String) -> void:
	if not status_container.has_node(str(peer_id)):
		var status = PeerStatus.instantiate()
		status_container.add_child(status)
		status.initialize(username)
		status.name = str(peer_id)

func remove_player(peer_id: int) -> void:
	var status = status_container.get_node(str(peer_id))
	if status:
		status.queue_free()

func set_status(peer_id: int, status: String) -> void:
	var status_node = status_container.get_node(str(peer_id))
	if status_node:
		status_node.set_status(status)

func get_status(peer_id: int) -> String:
	var status_node = status_container.get_node(str(peer_id))
	if status_node:
		return status_node.status
	return ''

func reset_status(status: String) -> void:
	for child in status_container.get_children():
		child.set_status(status)

func set_ready_button_enabled(enabled: bool = true) -> void:
	ready_button.disabled = !enabled
	if enabled:
		ready_button.grab_focus()

func _on_ready_button_pressed() -> void:
	emit_signal("ready_pressed")

func _on_BackButton_pressed():
	self.hide()
	emit_signal("back_pressed")

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
