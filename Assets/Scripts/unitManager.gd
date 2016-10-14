extends Node2D

var unit
var unit_scene = preload("res://Assets/Scenes/unit.tscn")
onready var players = get_node("../../Players")
onready var camera = get_tree().get_current_scene().get_node("Camera2D")
var unit_select_group = []
var distance = 10
var groups = 0
var count_tags = 0
onready var minimap = get_node("../../CanvasLayer/minimap")

var unit_images = {}
var unit_conf = load("res://Assets/Configs/unit_list.gd").new()

func list_files_in_directory(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			files.append(file)
	dir.list_dir_end()
	return files

func fill_box(unit_list):
	groups += 1
	var k = sqrt(unit_list.size())
	if  (k - floor(k)) != 0:	k = int(k) + 1
	else:	k = int(k)
	var co = []
	var uf = []
	for x in range(0, k): 
		var tmp = []
		for y in range(0, k):
			tmp.append(Vector2(distance * x, distance * y))
			uf.append(Vector2(x,y))
		co.append(tmp)
	print ('matrix_ok')
	return [co, uf]

func box(unit_list):
	var n = unit_list.size()
	var k = 1
	while (sqrt(n + k) - floor(sqrt(n + k))) != 0:	k += 1
	var r = n + k
	var l = sqrt(r)
	var f = pow((l-2), 2)
	if r == n + f:
		groups += 1
		var co = []
		var uf = []
		for x in range(0, l):
			var tmp = []
			for y in range(0, l):
				if x == 0 or y == 0 or x == l-1 or y == l-1:
					tmp.append(Vector2(distance * x, distance * y))
					uf.append(Vector2(x,y))	
				else:	tmp.append(null)
			co.append(tmp)
		return [co, uf]

func PlaceUnits(unit_list, result=null):
	if result == null:
		result = fill_box(unit_list)
	var co = result[0]
	var uf = result[1]
	var pos = 0
	count_tags += 1
	
	var angle = null
	
	for Unit in unit_list:
		#перемешает точки в позиции построения
		Unit.matrix_pos = co[ uf[pos].x ][ uf[pos].y ]  
		Unit.global_pos = camera.get_global_mouse_pos() 
		if angle == null:	angle = Unit.get_pos().angle_to_point(camera.get_global_mouse_pos())
		Unit.to_pos = Unit.matrix_pos.rotated(angle)+ Unit.global_pos
		Unit.angle = angle
		Unit.vec = (((Unit.to_pos - Unit.get_global_pos())).normalized())
		pos += 1

func _ready(): 
	for national in unit_conf.units.keys(): 
		for type in unit_conf.units[national]:
			for name in unit_conf.units[national][type]:
				var path_file_icon = "res://Assets/Textures/Units/" + name + ".png"
				if File.new().file_exists(path_file_icon) != true:
					unit_images[name] = load('res://Assets/Textures/Units/default.png')
				else:	unit_images[name] = load('res://Assets/Textures/Units/' + name + '.png')
	set_fixed_process(true)

func _fixed_process(delta):
	if Input.is_action_just_pressed("RKM") and not unit_select_group.empty():
		PlaceUnits (unit_select_group)	
	if Input.is_action_just_pressed("Delete") and not unit_select_group.empty():
		for unit in unit_select_group:	unit.dead() 
		unit_select_group = [] 

func add_unit(player_name, unit_name, unit_cord):
	unit = unit_scene.instance()
	unit.init(players.player_list[player_name], unit_name, unit_cord) 
	unit.set_pos(unit.coord) 
	add_child(unit)