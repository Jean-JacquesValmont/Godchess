extends Node

# For developers to set from the outside, for example:
#   Online.nakama_host = 'nakama.example.com'
#   Online.nakama_scheme = 'https'
var nakama_server_key: String = 'defaultkey'
var nakama_host: String = 'localhost'
var nakama_port: int = 7350
var nakama_scheme: String = 'http'

# For other scripts to access:
var _nakama_client
var nakama_client: NakamaClient: 
	set(v):
		_set_readonly_variable(v)
	get:
		return get_nakama_client()

var __nakama_session
var nakama_session: NakamaSession: 
	set(v):
		set_nakama_session(v)
	get:
		return __nakama_session

var _nakama_socket
var nakama_socket: NakamaSocket: 
	set(v):
		_set_readonly_variable(v)
	get:
		return _nakama_socket

# Internal variable for initializing the socket.
var _nakama_socket_connecting := false

signal session_changed (nakama_session)
signal session_connected (nakama_session)
signal socket_connected (nakama_socket)

func _set_readonly_variable(_value) -> void:
	pass

func _ready() -> void:
	# Don't stop processing messages from Nakama when the game is paused.
	Nakama.process_mode = Node.PROCESS_MODE_ALWAYS

func get_nakama_client() -> NakamaClient:
	if _nakama_client == null:
		_nakama_client = Nakama.create_client(
			nakama_server_key,
			nakama_host,
			nakama_port,
			nakama_scheme,
			Nakama.DEFAULT_TIMEOUT,
			NakamaLogger.LOG_LEVEL.ERROR)

	return _nakama_client

func set_nakama_session(_nakama_session: NakamaSession) -> void:
	__nakama_session = _nakama_session

	emit_signal("session_changed", __nakama_session)

	if __nakama_session and not __nakama_session.is_exception() and not nakama_session.is_expired():
		emit_signal("session_connected", __nakama_session)

func connect_nakama_socket() -> void:
	if _nakama_socket != null:
		return
	if _nakama_socket_connecting:
		return
	_nakama_socket_connecting = true

	var new_socket = Nakama.create_socket_from(_nakama_client)
	await new_socket.connect_async(__nakama_session)
	_nakama_socket = new_socket
	_nakama_socket_connecting = false

	emit_signal("socket_connected", _nakama_socket)

func is_nakama_socket_connected() -> bool:
	return _nakama_socket != null && _nakama_socket.is_connected_to_host()
