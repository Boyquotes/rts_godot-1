extends Node

var path = "res://Assets/Screenshots/"
var debug_line = preload ("res://Assets/Scenes/debug_line.tscn")
var cur_scene

func _ready():
	var dl = debug_line.instance()
	get_tree().get_current_scene().add_child(dl)
	cur_scene = get_tree().get_current_scene()
	set_process(true)

func _process(delta):
	if (get_tree().get_current_scene() != cur_scene):
		var dl = debug_line.instance()
		get_tree().get_current_scene().add_child(dl)
		cur_scene = get_tree().get_current_scene()
	else: 
		if Input.is_action_just_pressed("ScreenButton"):
			get_viewport().queue_screen_capture()
			# Let two frames pass to make sure the screen was captured
			yield(get_tree(), "idle_frame")
			yield(get_tree(), "idle_frame")
			# Retrieve the captured image  
			var img = get_viewport().get_screen_capture()
			var dt = OS.get_datetime()
			var png_path = path+str(dt.day)+"_"+str(dt.month)+"_"+str(dt.year)+"_"+str(dt.hour)+"_"+str(dt.minute)+"_"+str(dt.second)+".png"
			get_tree().get_current_scene().get_node("debug_line").queue.append("Save screenshot: "+png_path)
			img.save_png(png_path)