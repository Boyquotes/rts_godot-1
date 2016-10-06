extends Node2D
# George Linkovsky - GovnoCode (2016)
onready var cam = get_node("../Camera2D")
onready var dev_panel = get_node("../CanvasLayer/DevPanel")
onready var target_manager = get_node("../CanvasLayer/TargetPanel/targetManager")
export var select_color = Color(0,1,0,0.1)
export var select_color_border = Color(0,1,0)
var start_point = Vector2()
var last_point = Vector2()
var minimap_move = false
var selected = false

func controller_select():
	if Input.is_action_just_pressed("LKM"):
		#get_tree().call_group(2, "player_army", "selecting", start_point, last_point )
		start_point = cam.get_global_mouse_pos()
	if Input.is_action_pressed("LKM"):
		if minimap_move == false:
			selected = true
			last_point = cam.get_global_mouse_pos()
			update()
	elif Input.is_action_just_released("LKM"):
		get_tree().call_group(2, "player_army", "selecting", start_point, last_point )
		start_point = Vector2()
		last_point = Vector2()
		update() 

func _process(delta):

	if not((Input.is_action_pressed("DT_unit_add") and dev_panel.is_visible())):
		if ((target_manager.is_visible()) and
			((get_viewport().get_mouse_pos().y < target_manager.get_pos().y) or 
			(get_viewport().get_mouse_pos().x > (target_manager.get_pos().x + target_manager.get_size().x)))):	
			controller_select()
		elif not(target_manager.is_visible()):
			controller_select()




func draw_select_area():
	draw_rect(Rect2(start_point, last_point-start_point), select_color)
	draw_line(start_point, Vector2(start_point.x, last_point.y), select_color_border)
	draw_line(start_point, Vector2(last_point.x, start_point.y), select_color_border)
	draw_line(Vector2(start_point.x, last_point.y), last_point, select_color_border)
	draw_line(Vector2(last_point.x, start_point.y), last_point, select_color_border)

func _draw():
	draw_select_area()

func _ready():
	set_process(true)





