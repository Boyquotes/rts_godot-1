extends Node

var path = "res://Assets/Screenshots/"

func _ready():
	set_process(true)

func _process(delta):
	if Input.is_action_just_pressed("ScreenButton"):
		get_viewport().queue_screen_capture()
		# Let two frames pass to make sure the screen was captured
		yield(get_tree(), "idle_frame")
		yield(get_tree(), "idle_frame")
		# Retrieve the captured image
		var img = get_viewport().get_screen_capture()
		var dt = OS.get_datetime()
		var png_path = path+str(dt.day)+"_"+str(dt.month)+"_"+str(dt.year)+"_"+str(dt.hour)+"_"+str(dt.minute)+"_"+str(dt.second)+".png"
		print (png_path)
		img.save_png(png_path)