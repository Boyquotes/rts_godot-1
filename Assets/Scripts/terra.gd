extends TileMap
export var size_x = 10
export var size_y = 10

func _ready():
	var map = Map.new(size_x, size_y)
	var tilemap = get_node('.')
	map.render(size_x, size_y, tilemap)
 
class Map:
	var map = []
	const ID_GRASS = 0
	const ID_FOREST = 1
	
	func _init(size_x, size_y):
		for x in range(0, size_x):
			var tmp = [] 
			for y in range(0, size_y):
				tmp.append(ID_GRASS)
			map.append(tmp)
	
	func render(size_x, size_y, tilemap):
		for x in range(0, size_x):
			for y in range(0, size_y):
				tilemap.set_cell(x, y, map[x][y])
				
	func prn():
		print(map)
	
