extends Control

#onready var upd_timer_minimap = get_node('minimap_refresh')
onready var terra = get_node('../../world')
onready var grass = get_node('../../world/TileMap_terra')
onready var tf = get_node('WindowDialog/TextureFrame')
var imagetexture = ImageTexture.new()
onready var control_scene = get_node("../../Control")
onready var units_scene = get_node("../../world/units")
var colors = {0:Color(0, 1  , 0), 
			  1:Color(0, 100, 0),
	          2:Color(0, 100, 0),
	          3:Color(0, 1  , 0),
	          4:Color(0, 100, 0),
	          5:Color(0, 100, 0),
	          6:Color(0, 100, 0)}
var minimap_img
var minimap_img_default
	
func gen_minimap_terra(minimap_img):
	var i = 0
	while (i < terra.size_x): 
		var j = 0
		while (j < terra.size_y): 	
			minimap_img.put_pixel(i, j, colors[terra.map.map[i][j]])
			j+=1
		i+=1
	return minimap_img
		
func gen_minimap_units(minimap_img):
	for unit in units_scene.get_children():
		var c = grass.world_to_map(unit.get_global_pos())
		minimap_img.put_pixel(c.x, c.y, unit.diffuse_color_unit)
	return minimap_img

func _ready():	
	minimap_img = Image(terra.size_x, terra.size_y, false, 3)
	minimap_img = gen_minimap_terra(minimap_img)
	minimap_img_default = minimap_img
	imagetexture.create_from_image(minimap_img)
	imagetexture.set_flags(3)
	tf.set_texture(imagetexture)
	get_node('WindowDialog').show()

func _on_WindowDialog_mouse_enter():
	control_scene.minimap_move = true
	#control_scene.start_point = Vector2()
	#control_scene.last_point = Vector2()
	#control_scene.update()
	

func _on_WindowDialog_mouse_exit():
	control_scene.minimap_move = false


func _on_minimap_refresh_timeout():
	minimap_img = gen_minimap_units(minimap_img_default)
	imagetexture.create_from_image(minimap_img)
	imagetexture.set_flags(3)
	tf.set_texture(imagetexture)