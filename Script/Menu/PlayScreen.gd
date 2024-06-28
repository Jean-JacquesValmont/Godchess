extends Sprite2D

@onready var joinMatchID := $CustomMatch/IDMatchText
@onready var buttonCreate := $CustomMatch/ButtonCreate
@onready var buttonJoin := $CustomMatch/ButtonJoin

# Called when the node enters the scene tree for the first time.
func _ready():
	buttonCreate.connect("pressed", Callable(self, "_on_match_button_pressed").bind(OnlineMatch.MatchMode.CREATE))
	buttonJoin.connect("pressed", Callable(self, "_on_match_button_pressed").bind(OnlineMatch.MatchMode.JOIN))
	OnlineMatch.connect("match_joined", Callable(self, "_on_OnlineMatch_joined"))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_match_button_pressed(mode) -> void:
	# Connect socket to realtime Nakama API if not connected.
	if not Online.is_nakama_socket_connected():
		Online.connect_nakama_socket()
		await Online.socket_connected

	# Call internal method to do actual work.
	match mode:
		OnlineMatch.MatchMode.CREATE:
			_create_match()
		OnlineMatch.MatchMode.JOIN:
			_join_match()
	
func _create_match() -> void:
	OnlineMatch.create_match(Online.nakama_socket)
	get_node("/root/Menu/Background/CustomiseGameScreen/Options/StartGame").show()
	
func _join_match() -> void:
	var match_id = joinMatchID.text.strip_edges()
	if match_id == '':
		return
	if not match_id.ends_with('.'):
		match_id += '.'

	OnlineMatch.join_match(Online.nakama_socket, match_id)
	get_node("/root/Menu/Background/CustomiseGameScreen/Options/StartGame").hide()

func _on_OnlineMatch_joined(match_id: String, match_mode: int):
	var info = {
		players = OnlineMatch.__players,
		clear = true,
	}
	
	if match_mode != OnlineMatch.MatchMode.MATCHMAKER:
		info['match_id'] = match_id
		
	self.hide()
	get_node("/root/Menu/Background/CustomiseGameScreen").show()
	get_node("/root/Menu/Background/CustomiseGameScreen").callv("_show_screen", [info])


func _on_button_tutoriel_button_down():
	get_node("/root/Menu/Background/TutorielScreen").show()
	get_node("/root/Menu/Background/PlayScreen").hide()
