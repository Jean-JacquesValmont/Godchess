extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_play_button_down():
		get_tree().change_scene_to_file("res://Scene/Menu/Menu.tscn")

func _on_button_play_mouse_entered():
	get_node("AnimatedParticule").play("default")
	get_node("AnimatedRight").play("default")
	get_node("AnimatedLeft").play("default")

func _on_button_play_mouse_exited():
	get_node("AnimatedParticule").stop()
	get_node("AnimatedRight").stop()
	get_node("AnimatedLeft").stop()
