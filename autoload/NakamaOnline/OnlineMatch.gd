extends Node

# For developers to set from the outside, for example:
#   OnlineMatch.max_players = 8
#   OnlineMatch.client_version = 'v1.2'
var min_players := 2
var max_players := 2
var client_version := 'dev'

var _nakama_multiplayer_bridge
var nakama_multiplayer_bridge: NakamaMultiplayerBridge:
	set(v):
		_set_readonly_variable(v)
	get:
		return get_nakama_multiplayer_bridge()
#var nakama_multiplayer_bridge: NakamaMultiplayerBridge: set = _set_readonly_variable

# Nakama variables:
var __nakama_socket
var nakama_socket: NakamaClient: 
	set(v):
		_set_readonly_variable(v)
	get:
		return __nakama_socket

var _my_session_id
var my_session_id: String: 
	set(v):
		_set_readonly_variable(v)
	get:
		return get_my_session_id()

var _match_id
var match_id: String: 
	set(v):
		_set_readonly_variable(v)
	get:
		return get_match_id()

var _matchmaker_ticket
var matchmaker_ticket: String: 
	set(v):
		_set_readonly_variable(v)
	get:
		return get_matchmaker_ticket()

var __players
var players: Dictionary:
	set(v):
		_set_readonly_variable(v)
	get:
		return get_players()

enum MatchState {
	LOBBY = 0,
	MATCHING = 1,
	CONNECTING = 2,
	WAITING_FOR_ENOUGH_PLAYERS = 3,
	READY = 4,
	PLAYING = 5,
}
var _match_state
var match_state: int = MatchState.LOBBY: 
	set(v):
		_set_readonly_variable(v)
	get:
		return get_match_state()

enum MatchMode {
	NONE = 0,
	CREATE = 1,
	JOIN = 2,
	MATCHMAKER = 3,
}
var _match_mode = MatchMode.NONE
var match_mode: int = MatchMode.NONE: 
	set(v):
		_set_readonly_variable(v)
	get:
		return get_match_mode()

signal error (message)
signal disconnected ()

signal match_joined (_match_id, mode)

signal player_joined (player)
signal player_left (player)

signal match_ready (__players)
signal match_not_ready ()

class Player:
	var session_id: String
	var peer_id: int
	var username: String

	func _init(_session_id: String, _username: String, _peer_id: int) -> void:
		session_id = _session_id
		username = _username
		peer_id = _peer_id

	static func from_presence(presence: NakamaRTAPI.UserPresence, _peer_id: int) -> Player:
		return Player.new(presence.session_id, presence.username, _peer_id)

	static func from_dict(data: Dictionary) -> Player:
		return Player.new(data['session_id'], data['username'], int(data['peer_id']))

	func to_dict() -> Dictionary:
		return {
			session_id = session_id,
			username = username,
			peer_id = peer_id,
		}

static func serialize_players(_players: Dictionary) -> Dictionary:
	var result := {}
	for key in _players:
		result[key] = _players[key].to_dict()
	return result

static func unserialize_players(_players: Dictionary) -> Dictionary:
	var result := {}
	for key in _players:
		result[key] = Player.from_dict(_players[key])
	return result

func _set_readonly_variable(_value) -> void:
	pass

func _set_nakama_socket(_nakama_socket: NakamaSocket) -> void:
	print("Match_mode in _set_nakama_socket ", OnlineMatch._match_mode)
	if __nakama_socket == _nakama_socket:
		return

	if __nakama_socket:
		__nakama_socket.disconnect("closed", Callable(self, "_on_nakama_socket_closed"))

	if _nakama_multiplayer_bridge:
		_nakama_multiplayer_bridge.disconnect("match_joined", Callable(self, "_on_match_joined"))
		_nakama_multiplayer_bridge.disconnect("match_join_error", Callable(self, "_on_match_join_error"))
		_nakama_multiplayer_bridge.leave()
		_nakama_multiplayer_bridge = null
		get_tree().get_multiplayer().set_multiplayer_peer(null)
#		get_tree().network_peer = null

	__nakama_socket = _nakama_socket

	if __nakama_socket:
		__nakama_socket.connect("closed", Callable(self, "_on_nakama_socket_closed"))
		_nakama_multiplayer_bridge = NakamaMultiplayerBridge.new(__nakama_socket)
		_nakama_multiplayer_bridge.connect("match_joined", Callable(self, "_on_match_joined"))
		_nakama_multiplayer_bridge.connect("match_join_error", Callable(self, "_on_match_join_error"))
		print("_nakama_multiplayer_bridge._multiplayer_peer: ", _nakama_multiplayer_bridge._multiplayer_peer)
		get_tree().get_multiplayer().set_multiplayer_peer(_nakama_multiplayer_bridge._multiplayer_peer)
		print("get_tree().get_multiplayer().set_multiplayer_peer(_nakama_multiplayer_bridge._multiplayer_peer): ", get_tree().get_multiplayer().get_multiplayer_peer())
#		get_tree().network_peer = _nakama_multiplayer_bridge._multiplayer_peer

func _ready() -> void:
#	var tree = get_tree()
#	tree.connect("peer_connected", Callable(self, "_on_network_peer_connected"))
#	tree.connect("peer_disconnected", Callable(self, "_on_network_peer_disconnected"))
	pass

func create_match(_nakama_socket: NakamaSocket) -> void:
	leave()
	_set_nakama_socket(_nakama_socket)
	_nakama_multiplayer_bridge._multiplayer_peer.connect("peer_connected", Callable(self, "_on_network_peer_connected"))
	_nakama_multiplayer_bridge._multiplayer_peer.connect("peer_disconnected", Callable(self, "_on_network_peer_disconnected"))
	#match_mode = MatchMode.CREATE
	print("Create match middle: ", _match_mode)

	_nakama_multiplayer_bridge.create_match()
	_match_mode = MatchMode.CREATE
	print("Create match end: ", _match_mode)

func join_match(_nakama_socket: NakamaSocket, _match_id: String) -> void:
	leave()
	_set_nakama_socket(_nakama_socket)
	_nakama_multiplayer_bridge._multiplayer_peer.connect("peer_connected", Callable(self, "_on_network_peer_connected"))
	_nakama_multiplayer_bridge._multiplayer_peer.connect("peer_disconnected", Callable(self, "_on_network_peer_disconnected"))
	#match_mode = MatchMode.JOIN
	print("Join match middle: ", _match_mode)

	_nakama_multiplayer_bridge.join_match(_match_id)
	_match_mode = MatchMode.JOIN
	print("Join match end: ", _match_mode)

func start_matchmaking(_nakama_socket: NakamaSocket, data: Dictionary = {}) -> void:
	leave()
	_set_nakama_socket(_nakama_socket)
	#match_mode = MatchMode.MATCHMAKER
	print("start_matchmaking_mode OnlineMatch:", _match_mode)

	if data.has('min_count'):
		data['min_count'] = max(min_players, data['min_count'])
	else:
		data['min_count'] = min_players

	if data.has('max_count'):
		data['max_count'] = min(max_players, data['max_count'])
	else:
		data['max_count'] = max_players

	if client_version != '':
		if not data.has('string_properties'):
			data['string_properties'] = {}
		data['string_properties']['client_version'] = client_version

		var query = '+properties.client_version:' + client_version
		if data.has('query'):
			data['query'] += ' ' + query
		else:
			data['query'] = query

	_match_state = MatchState.MATCHING
	print("start_matchmaking_state OnlineMatch:", _match_state)
	print("start_matchmaking_mode OnlineMatch before result:", _match_mode)
	var result = await __nakama_socket.add_matchmaker_async(data.get('query', '*'), data['min_count'], data['max_count'], data.get('string_properties', {}), data.get('numeric_properties', {}))
	print("start_matchmaking_mode OnlineMatch after result:", _match_mode)
	_match_mode = MatchMode.MATCHMAKER
	print("start_matchmaking_mode OnlineMatch after result2:", _match_mode)
	if result.is_exception():
		print("start matchmaking_exception: ", result.get_exception().message)
		leave()
		emit_signal("error", "Unable to join match making pool")
	else:
		print("start matchmaking_mode OnlineMatch no exception:", _match_mode)
		_matchmaker_ticket = result.ticket
		_nakama_multiplayer_bridge.start_matchmaking(result)

func start_playing() -> void:
	assert(_match_state == MatchState.READY)
	_match_state = MatchState.PLAYING

func leave(close_socket: bool = false) -> void:
	print("Enter in function leave() of OnlineMatch")
	print("Match_mode in leave begin ", _match_mode)
	# Nakama disconnect.
	if _nakama_multiplayer_bridge:
		_nakama_multiplayer_bridge.leave()
	if __nakama_socket:
		if _matchmaker_ticket:
			await __nakama_socket.remove_matchmaker_async(_matchmaker_ticket)
		if close_socket:
			__nakama_socket.close()
			_set_nakama_socket(null)

	# Initialize all the variables to their default state.
	print("Initialize all the variables to their default state.")
	_match_id = ''
	__players = {}
	_match_state = MatchState.LOBBY
	_match_mode = MatchMode.NONE
	print("Match_mode in leave end ", _match_mode)

func get_nakama_multiplayer_bridge() -> NakamaMultiplayerBridge:
	return _nakama_multiplayer_bridge

func get_my_session_id() -> String:
	return _my_session_id

func get_match_id() -> String:
	if _nakama_multiplayer_bridge:
		return _nakama_multiplayer_bridge._match_id
	return ''

func get_matchmaker_ticket() -> String:
	return _matchmaker_ticket

func get_match_mode() -> int:
	return _match_mode

func get_match_state() -> int:
	return _match_state

func get_players() -> Dictionary:
	return __players

func get_player_names_by_peer_id() -> Dictionary:
	var result = {}
	for peer_id in __players:
		result[peer_id] = __players[peer_id].username
	return result

func _on_nakama_socket_closed() -> void:
	leave()
	emit_signal("disconnected")

func _check_enough_players() -> void:
	if __players.size() >= min_players:
		_match_state = MatchState.READY;
		emit_signal("match_ready", __players)
	else:
		_match_state = MatchState.WAITING_FOR_ENOUGH_PLAYERS
		emit_signal("match_not_ready")

func _on_match_joined() -> void:
	var my_peer_id = _nakama_multiplayer_bridge.multiplayer_peer._self_id
	print("my_peer_id: ", my_peer_id)
	var presence: NakamaRTAPI.UserPresence = _nakama_multiplayer_bridge.get_user_presence_for_peer(my_peer_id)
	print("presence", presence)
	var player = Player.from_presence(presence, my_peer_id)
	__players[my_peer_id] = player
	print("Match_joined in OnlineMatch: ", _match_mode)
	emit_signal("match_joined", _nakama_multiplayer_bridge._match_id, _match_mode)

@rpc func _boot_with_error(msg: String) -> void:
	leave()
	emit_signal("error", msg)

@rpc func _check_client_version(host_client_version: String) -> void:
	if client_version != host_client_version:
		leave()
		emit_signal("error", "Client version doesn't match host")

func _on_network_peer_connected(peer_id: int) -> void:
	if is_multiplayer_authority():
		if _match_state == MatchState.PLAYING:
			rpc_id(peer_id, "_boot_with_error", 'Sorry! The match has already begun.')
			return

		if __players.size() >= max_players:
			rpc_id(peer_id, "_boot_with_error", "Sorry! The match is full.")
			return

		# Ask the client to check it's client version.
		rpc_id(peer_id, "_check_client_version", client_version)

	var presence: NakamaRTAPI.UserPresence = _nakama_multiplayer_bridge.get_user_presence_for_peer(peer_id)
	var player = Player.from_presence(presence, peer_id)
	__players[peer_id] = player
	emit_signal("player_joined", player)

	_check_enough_players()

func _on_network_peer_disconnected(peer_id: int) -> void:
	var player = __players.get(peer_id)
	if player != null:
		emit_signal("player_left", player)
		players.erase(peer_id)

	_check_enough_players()
