extends Node2D
# George Linkovsky - GovnoCode (2016)
var start_point = Vector2()
var last_point = Vector2()

func _process(delta):
	if Input.is_action_just_pressed("LKM"):
		start_point = get_node("Camera2D").get_global_mouse_pos()
	if Input.is_action_pressed("LKM"):
		last_point = get_node("Camera2D").get_global_mouse_pos()
		update()
	elif Input.is_action_just_released("LKM"):
		get_tree().call_group(2,"solider", "selecting", start_point, last_point )
		start_point = Vector2()
		last_point = Vector2()
		update()

func _draw():
	draw_rect(Rect2(start_point, last_point-start_point),Color (0,1,0,0.1))
	draw_line(start_point, Vector2(start_point.x, last_point.y),Color (0,1,0))
	draw_line(start_point, Vector2(last_point.x, start_point.y),Color (0,1,0))
	draw_line(Vector2(start_point.x, last_point.y),last_point,Color (0,1,0))
	draw_line(Vector2(last_point.x, start_point.y),last_point,Color (0,1,0))

func _ready():
	set_process(true)