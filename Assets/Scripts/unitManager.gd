extends Node2D
var unit
onready var players = get_node("../../Players")
var unit_scene = preload("res://Assets/Scenes/unit.tscn")
var unit_select_group = []
onready var camera = get_tree().get_current_scene().get_node("Camera2D")
var distance = 10

class FillEntry:
	var x
	var y
	func _init(X, Y):
		x = X
		y = Y

func PlaceUnits(unit_list):
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
	print (co)
	var pos = 0
	for Unit in unit_list:
		#перемешает точки в позиции построения
		Unit.to_pos = co[uf[pos].x][uf[pos].y]+camera.get_global_mouse_pos()
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
			

func add_unit(player_name, unit_name, unit_cord):
	unit = unit_scene.instance()
	unit.unit_class = unit.Unit.new(players.playerList[player_name], unit_name, unit_cord) 
	unit.set_pos(unit.unit_class.cord) 
	add_child(unit)
  