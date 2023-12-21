extends Sprite2D

signal godSelected(godName : String)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("DisplaySpriteGod").texture = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_goddess_of_teleportation_button_down():
	GlobalValueMenu.godSelect = "GoddessOfTeleportation"
	emit_signal("godSelected", "GoddessOfTeleportation")
	get_node("DisplaySpriteGod").texture = null
	self.hide()
	get_node("/root/Menu/Background/PowerGods").show()

func _on_goddess_of_teleportation_mouse_entered():
	get_node("DisplaySpriteGod").texture = load("res://Image/Gods/GoddessOfTeleportation/Déesse de la Téléportation IA - Couleur.png")

func _on_goddess_of_teleportation_mouse_exited():
	get_node("DisplaySpriteGod").texture = null

func _on_god_of_death_button_down():
	GlobalValueMenu.godSelect = "GodOfDeath"
	emit_signal("godSelected", "GodOfDeath")
	get_node("DisplaySpriteGod").texture = null
	self.hide()
	get_node("/root/Menu/Background/PowerGods").show()

func _on_god_of_death_mouse_entered():
	get_node("DisplaySpriteGod").texture = load("res://Image/Gods/GodOfDeath/Dieu de la Mort IA - Couleur.png")

func _on_god_of_death_mouse_exited():
	get_node("DisplaySpriteGod").texture = null
