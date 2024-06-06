extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("OngletTopScreen/Username").text = Online.nakama_session.username
	get_node("OngletTopScreen/ButtonPlayAnimated/AnimatedParticule").play("default")
	get_node("OngletTopScreen/ButtonPlayAnimated/AnimatedRight").play("default")
	get_node("OngletTopScreen/ButtonPlayAnimated/AnimatedLeft").play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_play_button_down():
	if OnlineMatch._match_mode == 1 or OnlineMatch._match_mode == 2:
		get_node("/root/Menu/Background/GodsScreen").hide()
		get_node("/root/Menu/Background/CustomiseGameScreen").show()
		get_node("/root/Menu/Background/PowerGods").hide()
		GlobalValueMenu.godSelect = ""
	else:
		get_node("/root/Menu/Background/PlayScreen").show()
		get_node("/root/Menu/Background/GodsScreen").hide()
		get_node("/root/Menu/Background/PowerGods").hide()
		GlobalValueMenu.godSelect = ""

func _on_button_play_mouse_entered():
	if get_node("/root/Menu/Background/PlayScreen").visible == false:
		get_node("OngletTopScreen/ButtonPlayAnimated/AnimatedParticule").play("default")
		get_node("OngletTopScreen/ButtonPlayAnimated/AnimatedRight").play("default")
		get_node("OngletTopScreen/ButtonPlayAnimated/AnimatedLeft").play("default")

func _on_button_play_mouse_exited():
	if get_node("/root/Menu/Background/PlayScreen").visible == false:
		get_node("OngletTopScreen/ButtonPlayAnimated/AnimatedParticule").stop()
		get_node("OngletTopScreen/ButtonPlayAnimated/AnimatedRight").stop()
		get_node("OngletTopScreen/ButtonPlayAnimated/AnimatedLeft").stop()

func _on_button_gods_button_down():
		get_node("/root/Menu/Background/PlayScreen").hide()
		get_node("/root/Menu/Background/GodsScreen").show()
		get_node("/root/Menu/Background/CustomiseGameScreen").hide()
		get_node("/root/Menu/Background/PowerGods").hide()
		GlobalValueMenu.godSelect = ""
		get_node("OngletTopScreen/ButtonPlayAnimated/AnimatedParticule").stop()
		get_node("OngletTopScreen/ButtonPlayAnimated/AnimatedRight").stop()
		get_node("OngletTopScreen/ButtonPlayAnimated/AnimatedLeft").stop()

func _on_button_quit_menu_button_down():
	get_node("ModalQuitGame").show()

func _on_button_quit_game_button_down():
	Online.nakama_session = null
	get_tree().change_scene_to_file("res://Scene/Main.tscn")

func _on_button_cancel_button_down():
	get_node("ModalQuitGame").hide()
