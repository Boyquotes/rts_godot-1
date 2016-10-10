extends Node2D
#  Copyright 2016 Derbin Dmitry

export var size_x = 200
export var size_y = 200
export var count_forest = 10
export var count_tree = 500
onready var tilemap_terra = get_node('TileMap_terra')
onready var tilemap_forest = get_node('TileMap_forest')
var map = Map.new(size_x, size_y, count_forest, count_tree)

func _ready():
	map.render([tilemap_terra, tilemap_forest])

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
		#if _z == 3:
		#	x = -x

class Map:
	var map = []
	const ID_GRASS = 0
	const ID_FOREST = 1
	const ID_FOREST2 = 2
	const ID_FOREST3 = 6
	const ID_FOREST4 = 4
	const ID_FOREST5 = 5
	const ID_GRASS2 = 3
	var DEFAULT_GRASS = ID_GRASS

	func _init(size_x, size_y, count_forest, count_tree):
		for x in range(0, size_x):
			var tmp = [] 
			for y in range(0, size_y):
				tmp.append(DEFAULT_GRASS)
			map.append(tmp)
		gen_forest(size_x, size_y, count_forest, count_tree)


	
	func gen_rnd_struct(size_x, size_y, count_struct_max, count_obj_max, tiles, type_rnd='full'):
		randomize() #need add fat len
		for count_struct in range(0, count_struct_max):
			var rnd_coord = RndCoord.new(size_x, size_y)
			var x = abs(rnd_coord.x)
			var y = abs(rnd_coord.y)
			var dir = 0
			var tile
			var count_obj = 0
			if type_rnd == 'struct':
				tile = tiles[randi() % tiles.size()]
			while count_obj != count_obj_max:
				dir = randi() % 4				
				if dir == 0  and x + 1 <= size_x:
					x += 1
				if dir == 1  and x - 1 <= 0:
					x += -1
				if dir == 2 and y + 1 <= size_y:
					y += 1
				if dir == 3 and y - 1 >= 0:
					y += -1
				if type_rnd == 'full':
					tile = tiles[randi() % tiles.size()]
				if size_x-1 > abs(x) and size_y-1 > abs(y):
					map[x][y] = tile
				count_obj += 1
	
	func gen_forest(size_x, size_y, count_forest, count_tree):
		gen_rnd_struct(size_x, size_y, count_forest, count_tree, [ID_FOREST, ID_FOREST2, ID_FOREST3, ID_FOREST4, ID_FOREST5])
	
	func set_default_grass(n):
		DEFAULT_GRASS = n
	
	func render(tilemaps):
		randomize()
		for tilemap in tilemaps:
			for x in range(0, map.size()):
				for y in range(0, map[0].size()):
					if tilemap.get_name() != 'TileMap_terra':
						if not(map[x][y] in [ID_GRASS, ID_GRASS2]):
							tilemap.set_cell(x, y, map[x][y]) #randi()%2,randi()%2,randi()%2
					else:
						tilemap.set_cell(x, y, DEFAULT_GRASS)
	func prn():
		print(map)
	
