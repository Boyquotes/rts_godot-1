extends Camera2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var zoom_step = 0.5
export var zoom_min = 0.5
export var zoom_max = 3.0
export var zoom_speed = 2.0
var zoom_target = 1
var last_mouse_pos = Vector2(0,0)
var world = get_parent()

var offset = Vector2()

func _ready():
	set_fixed_process(true)


func _fixed_process(delta):
	var cur_mouse_pos = get_viewport().get_mouse_pos()
	set_process_input(true)
	set_process(true)

func move_towards(current, target, maxdelta):
	if abs(target - current) <= maxdelta:
		return target
	return current + sign(target - current) * maxdelta


func _process(delta):
	var cur_mouse_pos = get_viewport().get_mouse_pos()
    # mouse panning
	if Input.is_mouse_button_pressed(BUTTON_MIDDLE) or (Input.is_mouse_button_pressed(BUTTON_LEFT) and Input.is_key_pressed(KEY_SHIFT)):
		if last_mouse_pos != cur_mouse_pos:
			offset = last_mouse_pos - cur_mouse_pos
	else:
		if (Input.is_action_pressed("ui_up")):
			offset += Vector2 (0,-10)
		if (Input.is_action_pressed("ui_down")):
			offset += Vector2 (0,10)
		if (Input.is_action_pressed("ui_left")):
			offset += Vector2 (-10,0)
		if (Input.is_action_pressed("ui_right")):
			offset += Vector2 (10,0) 
		translate(offset * get_zoom())
		offset = Vector2()

	var new_zoom = move_towards(get_zoom().x, zoom_target, zoom_speed * delta)
		#(k0 - m) * current / target + m
	set_zoom(Vector2(new_zoom, new_zoom))
	last_mouse_pos = get_viewport().get_mouse_pos()

func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON:
		if event.is_pressed() and not event.is_echo():
			if event.button_index == BUTTON_WHEEL_UP:
				zoom_target -= zoom_step * (1/(1+zoom_target))
                # zoom to mouse?
			if event.button_index == BUTTON_WHEEL_DOWN:
				zoom_target += zoom_step * (1/(1+zoom_target))
	zoom_target = clamp(zoom_target, zoom_min, zoom_max)