extends Sprite2D

signal godSelected(godName : String)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_goddess_of_teleportation_button_down():
	GlobalValueMenu.godSelect = "GoddessOfTeleportation"
	emit_signal("godSelected", "GoddessOfTeleportation")
	self.hide()
	get_node("/root/Menu/Background/PowerGods").show()


func _on_god_of_death_button_down():
	GlobalValueMenu.godSelect = "GodOfDeath"
	emit_signal("godSelected", "GodOfDeath")
	self.hide()
	get_node("/root/Menu/Background/PowerGods").show()
