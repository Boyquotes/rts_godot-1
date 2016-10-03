extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var font_color = Color(0,0,0)
onready var units_scene = get_node("../../world/units")
onready var control_scene = get_node("../../Control")
onready var target_army_grid = get_node("targetManager/ScrollContainer/VBoxContainer/GridContainer")

func _ready():
	set_process(true)
var i = 0

func _process(delta):
	#print (u_inst.unit_select_group)
	if units_scene.unit_select_group != []:
		show()
		if i == 0:
			var unit_count = {}
			for unit in units_scene.unit_select_group:
				if unit_count.has(unit.unit_obj.unit_name):
					unit_count[unit.unit_obj.unit_name] += 1
				else:
					unit_count[unit.unit_obj.unit_name] = 1
			for name in unit_count:
				var button = Button.new()
				button.set_name(name)
				button.set_text(str(unit_count[name]))
				var path_file_icon = "res://Assets/Textures/Units/" + name + ".png"
				if File.new().file_exists(path_file_icon) != true:
					path_file_icon = "res://Assets/Textures/Units/default.png"
				button.set_button_icon(load(path_file_icon))
				#button.set_stop_mouse(true)
				#button.set_ignore_mouse(true)
				button.set_flat(true)
				button.add_color_override("font_color", font_color)
				target_army_grid.add_child(button)
		i += 1
	else: #Если массив unit_select_group пуст, то удаляем элементы существующие в target_army_grid
		clean_target_grid(target_army_grid, ['LabelInfo'])
		i = 0
		hide()

func clean_target_grid(target_army_grid, exception=[]):
	for button_unit in target_army_grid.get_children():
		if not(button_unit.get_name() in exception):
			#free()
			target_army_grid.remove_child(button_unit) #возможно тут еще надо делать free!!!
			
func _on_Button_pressed():
	pass
	
#func _input_event(viewport, event, shape_idx):
#	# Convert event to local coordinates
#	if (event.type == InputEvent.MOUSE_MOTION):
#		event = make_input_local(event)
#		if control_scene.lock == false:
#			control_scene.lock = true

#func _mouse_exit():
#	control_scene.lock = false
#func _mouse_enter():
#	control_scene.lock = true
#	print ('1234567890')