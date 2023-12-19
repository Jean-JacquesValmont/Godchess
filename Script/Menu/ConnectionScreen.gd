extends Sprite2D

var email = ''
var password = ''

@onready var pathConnectionEmail = $EmailText
@onready var pathConnectionPassword = $PasswordText
@onready var pathConnectionErrorText = $ErreurTextConnection

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_login_button_button_down():
	
	email = pathConnectionEmail.text.strip_edges()
	password = pathConnectionPassword.text.strip_edges()
	
	var nakama_session = await Online.nakama_client.authenticate_email_async(email, password, null, false)
	
	if nakama_session.is_exception():
		
		var msg = nakama_session.get_exception().message
		print(msg)
		
		if msg == "Password must be at least 8 characters long.":
			pathConnectionErrorText.text = msg
		elif msg == "Username is required when email address is not supplied.":
			pathConnectionErrorText.text = "Email is required."
		elif msg == "User account not found.":
			pathConnectionErrorText.text = msg
		elif msg == "Invalid email address format.":
			pathConnectionErrorText.text = msg
		elif msg == "Invalid credentials.":
			pathConnectionErrorText.text = "Password invalid"
		
		pathConnectionEmail.text = ""
		pathConnectionPassword.text = ""
		email = ''
		password = ''
		pathConnectionErrorText.modulate = Color(1,0,0)
		
		Online.nakama_session = null
	else:
		Online.nakama_session = nakama_session
		self.hide()
		get_node("/root/Main/Background/ButtonPlayAnimated").show()
#		get_tree().change_scene_to_file("res://Scene/menu.tscn")

func _on_register_screen_button_button_down():
	pathConnectionEmail.text = ""
	pathConnectionPassword.text = ""
	self.hide()
	get_node("/root/Main/Background/RegisterScreen").show()
