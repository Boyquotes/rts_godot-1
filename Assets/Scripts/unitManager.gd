extends Node2D
var unit
onready var players = get_node("../../Players")
var unit_scene = preload("res://Assets/Scenes/unit.tscn")
var unit_select_group = []
onready var camera = get_tree().get_current_scene().get_node("Camera2D")
var distance = 10
var company_distance = 50
var unitFilling = [	FillEntry.new(2,2),
					FillEntry.new(2,3),
					FillEntry.new(2,1),
					FillEntry.new(2,4),
					FillEntry.new(2,0),
					FillEntry.new(3,2),
					FillEntry.new(3,3),
					FillEntry.new(3,1),
					FillEntry.new(3,4),
					FillEntry.new(3,0),
					FillEntry.new(1,2),
					FillEntry.new(1,3),
					FillEntry.new(1,1),
					FillEntry.new(1,4),
					FillEntry.new(1,0),
					FillEntry.new(4,2),
					FillEntry.new(4,3),
					FillEntry.new(4,1),
					FillEntry.new(4,4),
					FillEntry.new(4,0),
					FillEntry.new(0,2),
					FillEntry.new(0,3),
					FillEntry.new(0,1),
					FillEntry.new(0,4),
					FillEntry.new(0,0)]
var companyFilling=[FillEntry.new(2,2),
					FillEntry.new(2,3),
					FillEntry.new(2,1),
					FillEntry.new(2,4),
					FillEntry.new(2,0),
					FillEntry.new(3,2),
					FillEntry.new(3,3),
					FillEntry.new(3,1),
					FillEntry.new(3,4),
					FillEntry.new(3,0),
					FillEntry.new(1,2),
					FillEntry.new(1,3),
					FillEntry.new(1,1),
					FillEntry.new(1,4),
					FillEntry.new(1,0),
					FillEntry.new(4,2),
					FillEntry.new(4,3),
					FillEntry.new(4,1),
					FillEntry.new(4,4),
					FillEntry.new(4,0),
					FillEntry.new(0,2),
					FillEntry.new(0,3),
					FillEntry.new(0,1),
					FillEntry.new(0,4),
					FillEntry.new(0,0)]

class FillEntry:
	var x
	var y
	func _init(X, Y):
		x = X
		y = Y

var companyCord = [	[Vector2(-company_distance*2, company_distance*2),	Vector2(-company_distance, company_distance*2),	Vector2(0, company_distance*2),	Vector2(company_distance, company_distance*2),	Vector2(company_distance*2, company_distance*2)],
					[Vector2(-company_distance*2, company_distance),	Vector2(-company_distance, company_distance),	Vector2(0, company_distance),	Vector2(company_distance, company_distance),	Vector2(company_distance*2, company_distance)],
					[Vector2(-company_distance*2, 0),					Vector2(-company_distance, 0),					Vector2(0, 0),					Vector2(company_distance, 0),					Vector2(company_distance*2, 0)],
					[Vector2(-company_distance*2, -company_distance),	Vector2(-company_distance, -company_distance),	Vector2(0, -company_distance),	Vector2(company_distance, -company_distance),	Vector2(company_distance*2, -company_distance)],
					[Vector2(-company_distance*2, -company_distance*2),	Vector2(-company_distance, -company_distance*2),Vector2(0, -company_distance*2),Vector2(company_distance, -company_distance*2),	Vector2(company_distance*2, -company_distance*2)]]

# Линейно, рядами, распределение от центра.
var coordinates = [     [Vector2(-distance*2, distance*2),	Vector2(-distance, distance*2),	Vector2(0, distance*2),	Vector2(distance, distance*2),	Vector2(distance*2, distance*2)],
						[Vector2(-distance*2, distance),	Vector2(-distance, distance),	Vector2(0, distance),	Vector2(distance, distance),	Vector2(distance*2, distance)],
						[Vector2(-distance*2, 0),			Vector2(-distance, 0),			Vector2(0, 0),			Vector2(distance, 0),			Vector2(distance*2, 0)],
						[Vector2(-distance*2, -distance),	Vector2(-distance, -distance),	Vector2(0, -distance),	Vector2(distance, -distance),	Vector2(distance*2, -distance)],
						[Vector2(-distance*2, -distance*2),	Vector2(-distance, -distance*2),Vector2(0, -distance*2),Vector2(distance, -distance*2),	Vector2(distance*2, -distance*2)]]

func PlaceUnits(unit_list):
	var pos = 0
	var cpos = 0
	for Unit in unit_list:
		if (pos >= 25): pos = 0; cpos += 1
		if (cpos >= 25): continue
		var fe = unitFilling[pos]
		var ce = companyFilling[cpos]
		pos += 1
		Unit.to_pos = coordinates[fe.x][fe.y]+camera.get_global_mouse_pos() + companyCord[ce.x][ce.y]
	
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
  