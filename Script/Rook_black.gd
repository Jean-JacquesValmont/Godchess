extends Node2D

var player_in_game
var player_turn = "white"
var piece_select = "No piece selected"
var my_node_name = self.get_name()
var move_one_square = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _input(event):
	var mouse_pos = get_local_mouse_position()
#	if player_in_game != null:
#		print(player_in_game.keys()[0])
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed and player_in_game != null:
		
		if player_in_game.keys()[0] == OnlineMatch._nakama_multiplayer_bridge.multiplayer_peer._self_id:
		
			if event is InputEventMouseButton and event.is_pressed() \
			and event.button_index == MOUSE_BUTTON_LEFT and piece_select == "No piece selected":
				if mouse_pos.x >= 0 and mouse_pos.x <= self.texture.get_width() \
				and mouse_pos.y >= 0 and mouse_pos.y <= self.texture.get_height():
					piece_select = my_node_name
					print(piece_select)
						
			elif event is InputEventMouseButton and event.is_pressed()\
			and event.button_index == MOUSE_BUTTON_LEFT and piece_select == my_node_name:
				#Vérifie qu'on clique bien sur la bonne case et qu'il n'y pas de pièce dessus
				#Diagonal d'une case si une pièce adverse est présent sur la case
				if mouse_pos.x >= 0 and mouse_pos.x <= self.texture.get_width() \
				and mouse_pos.y >= 0 - move_one_square and mouse_pos.y <= self.texture.get_height() - move_one_square:
					#Bouge la pièce de move_one_square = 100 en y
					move_local_y(-move_one_square)
					piece_select = "No piece selected"
					rpc("position_update_for_other_players", move_one_square)
					print(piece_select)


@rpc("any_peer") func position_update_for_other_players(move_one_squareProp):
	move_local_y(-move_one_squareProp)

