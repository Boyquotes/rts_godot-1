extends Node2D
# George Linkovsky - GovnoCode (2016)
onready var cam = get_node("../Camera2D")
onready var dev_panel = get_node("../CanvasLayer/DevPanel")
onready var target_manager = get_node("../CanvasLayer/TargetPanel/targetManager")
onready var info_panel = get_node("../CanvasLayer/infoPanel/Panel")
onready var units_scene = get_node("../world/units")
export var select_color = Color(0,1,0,0.1)
export var select_color_border = Color(0,1,0)
var start_point = null
var last_point = null
var start_point_loc = null
var last_point_loc = null

onready var sel_ar = get_node("../CanvasLayer/select_area")

func drop_select():
	start_point = null
	last_point = null
	start_point_loc = null
	last_point_loc = null


func controller_select():
	if Input.is_action_just_pressed("LKM"):
		if start_point == null:
			if area_not_is_info_panel():
				start_point = cam.get_global_mouse_pos()
				start_point_loc = get_viewport().get_mouse_pos()
				last_point = cam.get_global_mouse_pos()
				last_point_loc = get_viewport().get_mouse_pos()
				get_tree().call_group(2, "player_army", "selecting", start_point, last_point)
				draw_select_area()
			else:
				drop_select()
				
	
	if Input.is_action_pressed("LKM"):	
		if start_point == null:
			if area_not_is_info_panel():
				start_point = cam.get_global_mouse_pos()
				start_point_loc = get_viewport().get_mouse_pos()
			else:
				drop_select()
		else:
			last_point = cam.get_global_mouse_pos()
			last_point_loc = get_viewport().get_mouse_pos()
			draw_select_area()

			
	if Input.is_action_just_released("LKM"):
		if start_point != null:
			get_tree().call_group(2, "player_army", "selecting", start_point, last_point)
		drop_select()
		sel_ar.hide()

func _process(delta):
	controller_select()
	

func draw_select_area():
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
		return false

func area_not_is_info_panel():
	if((info_panel.is_visible()) and 
		(get_viewport().get_mouse_pos().x < info_panel.get_global_pos().x)):
		return true
	else:
		start_point = cam.get_global_mouse_pos()
		start_point_loc = get_viewport().get_mouse_pos()
		return false

func _ready():
	set_process(true)



