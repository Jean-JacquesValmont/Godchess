extends HBoxContainer

@onready var name_label := $NameLabel
@onready var status_label := $StatusLabel

#var status := "": set = set_status
var __status
var status: 
	set(v):
		set_status(v)
	get:
		return __status

func initialize(_name: String, _status: String = "Connected.", _score: int = 0) -> void:
	name_label.text = _name
	self.status = _status

func set_status(_status: String) -> void:
	__status = _status
	status_label.text = __status

