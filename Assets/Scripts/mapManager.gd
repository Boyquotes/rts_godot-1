extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

onready var terra = get_node('../../terra')
onready var bt_ch_bkgr_map = get_node('bt_ch_background_map')
var path_file_icon1 = 'res://Assets/Textures/Map/grass.png'
var path_file_icon2 = 'res://Assets/Textures/Map/grass2.png'
var path_file_icon_cur = path_file_icon2

func _on_bt_ch_background_map_pressed():
	if path_file_icon_cur == path_file_icon1:
		terra.map.set_default_grass(0)
		bt_ch_bkgr_map.set_button_icon(load(path_file_icon2))
		path_file_icon_cur = path_file_icon2
	else:
		terra.map.set_default_grass(3)
		bt_ch_bkgr_map.set_button_icon(load(path_file_icon1))
		path_file_icon_cur = path_file_icon1
	terra.map.render([terra.tilemap_terra, terra.tilemap_forest])