extends Node2D

var unit
var unit_scene = preload("res://Assets/Scenes/unit.tscn")
onready var players = get_node("../../Players")
onready var camera = get_tree().get_current_scene().get_node("Camera2D")
var unit_select_group = []
var distance = 10
var groups = 0
var count_tags = 0


func rotate(vector, rad = 2.0944):# 0.785398
	var x = vector.x * cos(rad) - vector.y * sin(rad)
	var y = vector.x * sin(rad) + vector.y * cos(rad)
	return Vector2(x,y)
	
class FillEntry:
	var x
	var y
	func _init(X, Y):
		x = X
		y = Y

func fill_box(unit_list):
	groups += 1
	var k = sqrt(unit_list.size())
	if  (k - floor(k)) != 0:
		k = int(k) + 1
	else:
		k = int(k)
	var co = []
	var uf = []
	for x in range(0, k): 
		var tmp = []
		for y in range(0, k):
			tmp.append(Vector2(distance * x, distance * y))
			uf.append(FillEntry.new(x,y))
			print (x,y)
		co.append(tmp)
	#print (co)
	return [co, uf]

func box(unit_list):
	var n = unit_list.size()
	var k = 1
	while (sqrt(n + k) - floor(sqrt(n + k))) != 0:
		k += 1
	var r = n + k
	var l = sqrt(r)
	var f = pow((l-2), 2)
	#print ('r:',r,' n:',n,' f:',f)
	if r == n + f:
		groups += 1
		var co = []
		var uf = []
		for x in range(0, l):
			var tmp = []
			for y in range(0, l):
				if x == 0 or y == 0 or x == l-1 or y == l-1:
					tmp.append(Vector2(distance * x, distance * y))
					uf.append(FillEntry.new(x,y))	
				else:
					tmp.append(null)
			co.append(tmp)
		print (co)
		print(uf)
		return [co, uf]

func PlaceUnits(unit_list, result=null):
	if result == null:
		result = fill_box(unit_list)
	#Unit.unit_class.tag = count_tags
	var co = result[0]
	var uf = result[1]
	var pos = 0
	count_tags += 1
	for Unit in unit_list:
		#перемешает точки в позиции построения
		Unit.to_pos = rotate(co[ uf[pos].x ][ uf[pos].y ])+camera.get_global_mouse_pos()
		pos += 1
	
	
func _ready(): 
#	add_unit("Timofffee", "spearman", Vector2(2,20))
#	add_unit("Timofffee", "spearman", Vector2(30,20))
#	add_unit("Timofffee", "spearman", Vector2(40,30))
#	add_unit("Timofffee", "spearman", Vector2(50,30))
#	add_unit("Timofffee", "spearman", Vector2(60,10))
#	add_unit("Timofffee", "spearman", Vector2(70,50))
#	add_unit("Timofffee", "spearman", Vector2(80,60))
#	add_unit("Timofffee", "spearman", Vector2(90,10))
#	add_unit("Timofffee", "spearman", Vector2(55,5))
#	add_unit("Timofffee", "spearman", Vector2(25,10))
#	add_unit("Timofffee", "spearman", Vector2(15,20))
#	add_unit("Timofffee", "spearman", Vector2(10,5))
	set_fixed_process(true)

func _fixed_process(delta):
	if Input.is_action_just_pressed("RKM") and not unit_select_group.empty():
		PlaceUnits (unit_select_group)
			
	if Input.is_action_just_pressed("Delete") and not unit_select_group.empty():
		for unit in unit_select_group:
			unit.free()
		unit_select_group = [] 

func add_unit(player_name, unit_name, unit_cord):
	unit = unit_scene.instance()
	unit.unit_obj = unit.Unit.new(players.player_list[player_name], unit_name, unit_cord) 
	unit.set_pos(unit.unit_obj.cord) 
	add_child(unit)
  