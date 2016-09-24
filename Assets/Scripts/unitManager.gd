extends Node2D
var unit
onready var players = get_node("../../Players")
var unit_scene = preload("res://Assets/Scenes/unit.tscn")
var unit_select_group = []
onready var camera = get_tree().get_current_scene().get_node("Camera2D")
var dead_zone = 4

func _ready(): 
	add_unit("Timofffee", "spearman", Vector2(2,10))
	add_unit("Timofffee", "spearman", Vector2(20,10))	
	add_unit("Timofffee", "spearman", Vector2(30,40))
	add_unit("Timofffee", "spearman", Vector2(40,50))
	add_unit("Timofffee", "spearman", Vector2(50,30))	
	add_unit("Timofffee", "spearman", Vector2(60,20))
	add_unit("Timofffee", "spearman", Vector2(70,20))
	add_unit("Timofffee", "spearman", Vector2(20,70))	
	add_unit("Timofffee", "spearman", Vector2(20,80))
	add_unit("Timofffee", "spearman", Vector2(40,10))
	add_unit("Timofffee", "spearman", Vector2(90,20))	
	add_unit("Timofffee", "spearman", Vector2(20,20))
	set_fixed_process(true)

func _fixed_process(delta):
	if Input.is_action_just_pressed("RKM") and not unit_select_group.empty():
		for u in unit_select_group:
			u.to_pos = camera.get_global_mouse_pos()
			

func add_unit(player_name, unit_type, unit_cord):
	unit = unit_scene.instance()
	unit.unit_class = unit.Unit.new(players.playerList[player_name], unit_type, unit_cord) 
	unit.set_pos(unit.unit_class.cord) 
	add_child(unit)
  