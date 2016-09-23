extends TileMap
#  Copyright 2016 Derbin Dmitry

export var size_x = 40
export var size_y = 40
export var count_forest = 8
export var count_tree = 36

func _ready():
	var map = Map.new(size_x, size_y, count_forest, count_tree)
	var tilemap = get_node('.')
	map.render(size_x, size_y, tilemap)

class RndCoord:
	var x 
	var y 
	func _init(x_max, y_max):
		x = randi() % x_max
		y = randi() % y_max
		var _z = randi() % 4
		if _z == 1:
			x = -x
			y = -y
		if _z == 2:
			y = -y
		if _z == 3:
			x = -x

class Map:
	var map = []
	const ID_GRASS = 0
	const ID_FOREST = 1
	
	func _init(size_x, size_y, count_forest, count_tree):
		for x in range(0, size_x):
			var tmp = [] 
			for y in range(0, size_y):
				tmp.append(ID_GRASS)
			map.append(tmp)
		gen_forest(size_x, size_y, count_forest, count_tree)
	
	func gen_rnd_struct(size_x, size_y, count_struct_max, count_obj_max, tiles, type_rnd='full'):
		randomize() #need add fat len
		for count_struct in range(0, count_struct_max):
			var rnd_coord = RndCoord.new(size_x, size_y)
			var x = rnd_coord.x
			var y = rnd_coord.y
			var dir = 0
			var tile
			var count_obj = 0
			if type_rnd == 'struct':
				tile = tiles[randi() % tiles.size()]
			while count_obj != count_obj_max:
				dir = randi() % 4
				if dir == 0:
					x += 1
				if dir == 1:
					x += -1
				if dir == 2:
					y += 1
				if dir == 3:
					y += -1
				if type_rnd == 'full':
					tile = tiles[randi() % tiles.size()]
				if size_x > abs(x) and size_y > abs(y):
					map[x][y] = tile
					count_obj += 1
	
	func gen_forest(size_x, size_y, count_forest, count_tree):
		gen_rnd_struct(size_x, size_y, count_forest, count_tree, [ID_FOREST])
		
	func render(size_x, size_y, tilemap):
		for x in range(0, size_x):
			for y in range(0, size_y):
				tilemap.set_cell(x, y, map[x][y])
				
	func prn():
		print(map)
	
