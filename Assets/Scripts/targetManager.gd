extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var u_inst = get_node("../../terra/units")
onready var prop = get_node("target_manager/ScrollContainer/VBoxContainer")
func _ready():
	set_process(true)
var i = 0
func _process(delta):
	print (u_inst.unit_select_group)
	if u_inst.unit_select_group != []:
		show()
		if i == 0:
			var d = {}
			for unit in u_inst.unit_select_group:
				if d.has(unit.unit_class.type):
					d[unit.unit_class.type] = d[unit.unit_class.type] + 1
				else:
					d[unit.unit_class.type] = 1
			for key in d:
				var label = Label.new()
				label.set_text(key + ' ' + str(d[key]))
				prop.add_child(label)
		i += 1
	else:
		for unit in prop.get_children():
			if unit.get_name() != 'LabelProp':
				prop.remove_child(unit)
		i = 0
		hide()