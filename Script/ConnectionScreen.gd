extends Control

var email = ''
var password = ''
var username = ''

@onready var path_connection_email = $Panel/ConnectionScreen/EmailText
@onready var path_connection_password = $Panel/ConnectionScreen/PasswordText
@onready var path_register_username = $Panel/RegisterScreen/UsernameText
@onready var path_register_email = $Panel/RegisterScreen/EmailText
@onready var path_register_password = $Panel/RegisterScreen/PasswordText
@onready var path_connection_error_text = $Panel/ConnectionScreen/ErreurTextConnection
@onready var path_register_error_text = $Panel/RegisterScreen/ErreurTextRegister

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_LoginButton_pressed():
	
	email = path_connection_email.text.strip_edges()
	password = path_connection_password.text.strip_edges()
	
	var nakama_session = await Online.nakama_client.authenticate_email_async(email, password, null, false)
	
	if nakama_session.is_exception():
		
		var msg = nakama_session.get_exception().message
		print(msg)
		
		if msg == "Password must be at least 8 characters long.":
			path_connection_error_text.text = msg
		elif msg == "Username is required when email address is not supplied.":
			path_connection_error_text.text = "Email is required."
		elif msg == "User account not found.":
			path_connection_error_text.text = msg
		elif msg == "Invalid email address format.":
			path_connection_error_text.text = msg
		elif msg == "Invalid credentials.":
			path_connection_error_text.text = "Password invalid"
		
		path_connection_email.text = ""
		path_connection_password.text = ""
		email = ''
		password = ''
		
		Online.nakama_session = null
	else:
		Online.nakama_session = nakama_session
		self.hide()
	
func _on_RegisterButton_pressed():
	
	username = path_register_username.text.strip_edges()
	email = path_register_email.text.strip_edges()
	password = path_register_password.text.strip_edges()
	
	var nakama_session = await Online.nakama_client.authenticate_email_async(email, password, username, true)
	
	if nakama_session.is_exception():
		
		var msg = nakama_session.get_exception().message
		path_register_error_text.modulate = Color(1,0,0)
		print(msg)
		if msg == "Password must be at least 8 characters long.":
			path_register_error_text.text = msg
		elif msg == "Username is required when email address is not supplied.":
			path_register_error_text.text = msg
		elif msg == "User account not found.":
			path_register_error_text.text = msg
		elif msg == "Invalid email address format.":
			path_register_error_text.text = msg
		elif msg == "Invalid credentials.":
			path_register_error_text.text = "The account already exists"
		
		Online.nakama_session = null
		
	else:
		Online.nakama_session = nakama_session
		path_register_username.text = ""
		path_register_email.text = ""
		path_register_password.text = ""
		path_register_error_text.text = "Création du compte validé."
		path_register_error_text.modulate = Color(0,1,0)
