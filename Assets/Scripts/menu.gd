extends Control

const aspect_ratio_4x3 = 4.0/3.0
const aspect_ratio_16x9 = 16.0/9.0
const aspect_ratio_5x4 = 5.0/4.0
const path_splash = 'res://Assets/Textures/Splash/'
onready var tf = get_node('ParallaxBackground/TextureFrame')
onready var ui_player = get_node("UI_player")

func _ready():
	pass
#	var screen_size = OS.get_window_size() 
#	var r = screen_size.x / screen_size.y 
#	print(screen_size, ' ', r)
#	if r == aspect_ratio_4x3:		tf.set_texture(load(path_splash + '1_4x3.jpg'))
#	elif r == aspect_ratio_5x4:		tf.set_texture(load(path_splash + '1_5x4.jpg'))
#	else:							tf.set_texture(load(path_splash + '1_16x9.jpg'))

func _on_bt_exit_pressed():
	get_tree().quit()

func _on_bt_focus_enter():
	ui_player.play("button_focus_enter")

func _on_bt_sandbox_pressed():
	get_tree().change_scene("res://Assets/Scenes/main.tscn")
