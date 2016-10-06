extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var terra = get_node('../../../../world')


func _ready():
	pass
	
func _draw():
	var colors = {1:Color(0.3,0.6,0.2), 0:Color(0, 1, 0), 2:Color(0.3,0.6,0.2),3:Color(0,1,0),4:Color(0.3,0.6,0.2),5:Color(0.3,0.6,0.2),6:Color(0.3,0.6,0.2)}
	var SIZE_RECT = 100 / terra.size_x
	var i = 0
	while (i < terra.size_x): 
		var j = 0
		while (j < terra.size_y): 	
			draw_rect(Rect2(Vector2(i * SIZE_RECT, j*SIZE_RECT), Vector2(SIZE_RECT,SIZE_RECT)), colors[terra.map.map[i][j]])
			j+=1
		i+=1	
