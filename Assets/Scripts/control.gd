extends Node2D
# George Linkovsky - GovnoCode (2016)
onready var cam = get_node("../Camera2D")
onready var dev_panel = get_node("../CanvasLayer/DevPanel")
onready var target_manager = get_node("../CanvasLayer/TargetPanel/targetManager")
onready var info_panel = get_node("../CanvasLayer/infoPanel/Panel")
onready var units_scene = get_node("../world/units")
export var select_color = Color(0,1,0,0.1)
export var select_color_border = Color(0,1,0)
var start_point = Vector2()
var last_point = Vector2()
var start_point_loc = Vector2()
var last_point_loc = Vector2()
var minimap_move = false

func controller_select():
	if Input.is_action_just_pressed("LKM"):
		for unit in units_scene.unit_select_group:
			unit.unselect()
		start_point = cam.get_global_mouse_pos()
		start_point_loc = get_viewport().get_mouse_pos()
	if Input.is_action_pressed("LKM"):
		last_point = cam.get_global_mouse_pos()
		last_point_loc = get_viewport().get_mouse_pos()
		draw_select_area()
	elif Input.is_action_just_released("LKM"):
		get_tree().call_group(2, "player_army", "selecting", start_point, last_point)
		start_point = Vector2()
		last_point = Vector2()
		start_point_loc = Vector2()
		last_point_loc = Vector2()
		draw_select_area()

func _process(delta):
	if not((Input.is_action_pressed("DT_unit_add") and dev_panel.is_visible())):
		if area_not_is_info_panel():
			if area_not_is_target_manager():
				controller_select()
			elif not(target_manager.is_visible()):
				controller_select()
		else:		
			if Input.is_action_just_released("LKM"):
				get_tree().call_group(2, "player_army", "selecting", start_point, last_point)
				start_point = Vector2()
				last_point = Vector2()
				start_point_loc = Vector2()
				last_point_loc = Vector2()
				draw_select_area()

func draw_select_area():
	var sel_ar = get_node("../CanvasLayer/select_area")
	sel_ar.show()
	if (start_point_loc.x < last_point_loc.x):
		sel_ar.set_margin(0,start_point_loc.x)
		sel_ar.set_margin(2,last_point_loc.x)
	else:
		sel_ar.set_margin(2,start_point_loc.x)
		sel_ar.set_margin(0,last_point_loc.x)
	if (start_point_loc.y < last_point_loc.y):
		sel_ar.set_margin(1,start_point_loc.y)
		sel_ar.set_margin(3,last_point_loc.y)
	else:
		sel_ar.set_margin(3,start_point_loc.y)
		sel_ar.set_margin(1,last_point_loc.y)

func area_not_is_target_manager():
	if((target_manager.is_visible()) and
		((get_viewport().get_mouse_pos().y < target_manager.get_global_pos().y) or 
		(get_viewport().get_mouse_pos().x > (target_manager.get_global_pos().x + target_manager.get_size().x)))):
		return true
	else:
		false

func area_not_is_info_panel():
	if((info_panel.is_visible()) and 
		(get_viewport().get_mouse_pos().x < info_panel.get_global_pos().x)):
		return true
	else:
		false

func _ready():
	draw_select_area();	set_process(true)

#func controller_select():
#	if Input.is_action_just_pressed("LKM"):
#		for unit in units_scene.unit_select_group:	
#			unit.unselect()
#		if minimap_move == false:
#			start_point = cam.get_global_mouse_pos()
#			start_point_loc = get_viewport().get_mouse_pos()
#	if Input.is_action_pressed("LKM"):
#		if minimap_move == false:
#			last_point = cam.get_global_mouse_pos()
#			last_point_loc = get_viewport().get_mouse_pos()
#			draw_select_area()
#	elif Input.is_action_just_released("LKM"):
#		if minimap_move == false:
#			get_tree().call_group(2, "player_army", "selecting", start_point, last_point)
#		start_point = Vector2()
#		last_point = Vector2()
#		start_point_loc = Vector2()
#		last_point_loc = Vector2()
#		draw_select_area()



