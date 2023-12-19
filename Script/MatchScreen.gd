extends Control

@onready var join_match_id := $Panel/JoinMatch/IDMatchText
@onready var display_timer_find_match := $Panel/FindMatch/DisplayTimerFindMatch
var timer_running: bool = false
var timer: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Panel/FindMatch/SearchButton.connect("pressed", Callable(self, "_on_match_button_pressed").bind(OnlineMatch.MatchMode.MATCHMAKER))
	$Panel/CreateMatch/CreateButton.connect("pressed", Callable(self, "_on_match_button_pressed").bind(OnlineMatch.MatchMode.CREATE))
	$Panel/JoinMatch/JoinButton.connect("pressed", Callable(self, "_on_match_button_pressed").bind(OnlineMatch.MatchMode.JOIN))

	OnlineMatch.connect("match_joined", Callable(self, "_on_OnlineMatch_joined"))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer_running:
		timer += delta
		update_timer_label()

func update_timer_label() -> void:
	var total_seconds = float(timer)
	var minutes = total_seconds / 60
	var seconds = total_seconds % 60
	display_timer_find_match.text = "Finding a match: " + str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)
	if self.visible == false :
		display_timer_find_match.visible = false
		$Panel/FindMatch/SearchButton.text = "Search"
		timer_running = false
		timer = 0

func _on_match_button_pressed(mode) -> void:
	# Connect socket to realtime Nakama API if not connected.
	if not Online.is_nakama_socket_connected():
		Online.connect_nakama_socket()
		await Online.socket_connected

	# Call internal method to do actual work.
	match mode:
		OnlineMatch.MatchMode.MATCHMAKER:
			if $Panel/FindMatch/SearchButton.text == "Search" :
				print("Start_matchmaking")
				_start_matchmaking()
			elif $Panel/FindMatch/SearchButton.text == "Cancel" : 
				print("Cancel matchmaking")
				OnlineMatch.leave()
				display_timer_find_match.visible = false
				$Panel/FindMatch/SearchButton.text = "Search"
				timer_running = false
				timer = 0
		OnlineMatch.MatchMode.CREATE:
			print("Create_matchmaking")
			_create_match()
		OnlineMatch.MatchMode.JOIN:
			print("Join_matchmaking")
			_join_match()

func _start_matchmaking() -> void:
	var min_players = 2

	var data = {
		min_count = min_players,
		string_properties = {
			game = "ChessGame",
			engine = "godot",
		},
		query = "+properties.game:ChessGame +properties.engine:godot",
	}

	OnlineMatch.start_matchmaking(Online.nakama_socket, data)
	
	timer_running = true
	display_timer_find_match.visible = true
	$Panel/FindMatch/SearchButton.text = "Cancel"
	
	
func _create_match() -> void:
	OnlineMatch.create_match(Online.nakama_socket)
	
func _join_match() -> void:
	var match_id = join_match_id.text.strip_edges()
	if match_id == '':
		print("match id empty")
		return
	if not match_id.ends_with('.'):
		match_id += '.'

	OnlineMatch.join_match(Online.nakama_socket, match_id)

func _on_OnlineMatch_joined(match_id: String, match_mode: int):
	print("Match_mode in OnlineMatch_joined: ", match_mode)
	print("OnlineMatch.__players in OnlineMatch_joined: ", OnlineMatch.__players)
	var info = {
		players = OnlineMatch.__players,
		clear = true,
	}
	print("info in OnlineMatch_joined: ", info)
	if match_mode != OnlineMatch.MatchMode.MATCHMAKER:
		info['match_id'] = match_id
		
	self.hide()
	emit_signal("hidden", info)

