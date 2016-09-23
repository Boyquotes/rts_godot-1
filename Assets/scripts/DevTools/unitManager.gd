extends Node2D
var unit
onready var player_list = get_node("/root/players").playerList
var unit_scene = preload("res://Assets/Scenes/unit.tscn")
	
func _ready(): 
	add_unit("Timofffee", "spearman", Vector2(20,20))

func add_unit(player_name, unit_type, unit_cord):
	unit = unit_scene.instance()
	var unit_class = unit.Unit.new(player_list[player_name], unit_type, unit_cord) 
	unit.set_pos(unit_class.cord)
	add_child(unit)
