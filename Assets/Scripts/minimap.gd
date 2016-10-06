extends Control

onready var terra = get_node('../../world')
onready var tf = get_node('WindowDialog/TextureFrame')
var imagetexture = ImageTexture.new()
onready var control_scene = get_node("../../Control")

func _ready():
	var colors = {1:Color(0,100,0), 0:Color(0, 1, 0), 2:Color(0,100,0),3:Color(0,1,0),4:Color(0,100,0),5:Color(0,100,0),6:Color(0,100,0)}
	var i = 0
	var minimap_img = Image(terra.size_x, terra.size_y, false, 3)
	while (i < terra.size_x): 
		var j = 0
		while (j < terra.size_y): 	
			minimap_img.put_pixel(i, j, colors[terra.map.map[i][j]])
			j+=1
		i+=1
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
