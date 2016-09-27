extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var font_color = Color(0,0,0)
onready var u_inst = get_node("../../terra/units")
onready var prop = get_node("target_manager/ScrollContainer/VBoxContainer/GridContainer")
func _ready():
	set_process(true)
var i = 0
func _process(delta):
	#print (u_inst.unit_select_group)
	if u_inst.unit_select_group != []:
		show()
		if i == 0:
			var d = {}
			for unit in u_inst.unit_select_group:
				if d.has(unit.unit_class.unit):
					d[unit.unit_class.unit] = d[unit.unit_class.unit] + 1
				else:
					d[unit.unit_class.unit] = 1
			for key in d:
				var button = Button.new()
				button.set_name(key)
				button.set_text(str(d[key]))
				var path_file_icon = "res://Assets/Textures/Units/" + key + ".png"
				if File.new().file_exists(path_file_icon) != true:
					path_file_icon = "res://Assets/Textures/Units/default.png"
				button.set_button_icon(load(path_file_icon))
				button.set_stop_mouse(true)
				button.set_ignore_mouse(true)
				button.set_flat(true)
				button.add_color_override("font_color", font_color)
				prop.add_child(button)
		i += 1
	else:
		for unit in prop.get_children():
			if unit.get_name() != 'LabelProp':
				prop.remove_child(unit)
		i = 0
		hide()