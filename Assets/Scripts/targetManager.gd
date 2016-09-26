extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var u_inst = get_node("../../terra/units")
func _ready():
	set_process(true)

func _process(delta):
	if u_inst.unit_select_group != []:
		show()
	else:
		hide()
