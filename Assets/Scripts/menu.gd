extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const path_splash = 'res://Assets/Textures/Splash/'
onready var tf = get_node('ParallaxBackground/TextureFrame')
func _ready():
	#var projectResolution=Vector2(Globals.get("display/width"),Globals.get("display/height"))
	var aspect_ratio_4x3 = 1.25
	var screen_size = OS.get_screen_size()
	var r = screen_size.x / screen_size.y
	print(screen_size, ' ', r)
	if r == aspect_ratio_4x3:
		tf.set_texture(load(path_splash + '1_4x3.jpg'))
	else:
		tf.set_texture(load(path_splash + '1_16x9.jpg'))
		
