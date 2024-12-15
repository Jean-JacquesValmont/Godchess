extends Sprite2D

signal godSelected(godName : String)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("DisplaySpriteGod").texture = null
	get_node("HoverSelectionGods").texture = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_goddess_of_teleportation_button_down():
	GlobalValueMenu.godSelect = "GoddessOfTeleportation"
	emit_signal("godSelected", "GoddessOfTeleportation")
	get_node("DisplaySpriteGod").texture = null
	get_node("HoverSelectionGods").texture = null
	self.hide()
	get_node("/root/Menu/Background/PowerGods").show()

func _on_goddess_of_teleportation_mouse_entered():
	get_node("DisplaySpriteGod").texture = load("res://Image/Gods/GoddessOfTeleportation/Déesse de la Téléportation IA - Couleur.png")
	get_node("HoverSelectionGods").texture = load("res://Image/Menu/HoverSelectionGods.png")
	get_node("HoverSelectionGods").position.x = 5
	get_node("HoverSelectionGods").position.y = 130

func _on_goddess_of_teleportation_mouse_exited():
	get_node("DisplaySpriteGod").texture = null
	get_node("HoverSelectionGods").texture = null

func _on_god_of_death_button_down():
	GlobalValueMenu.godSelect = "GodOfDeath"
	emit_signal("godSelected", "GodOfDeath")
	get_node("DisplaySpriteGod").texture = null
	get_node("HoverSelectionGods").texture = null
	self.hide()
	get_node("/root/Menu/Background/PowerGods").show()

func _on_god_of_death_mouse_entered():
	get_node("DisplaySpriteGod").texture = load("res://Image/Gods/GodOfDeath/Dieu de la Mort IA - Couleur.png")
	get_node("HoverSelectionGods").texture = load("res://Image/Menu/HoverSelectionGods.png")
	get_node("HoverSelectionGods").position.x = 262
	get_node("HoverSelectionGods").position.y = 130

func _on_god_of_death_mouse_exited():
	get_node("DisplaySpriteGod").texture = null
	get_node("HoverSelectionGods").texture = null
