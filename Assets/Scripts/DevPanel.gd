extends Control

var current_unit = null

onready var cam = get_node("../../Camera2D")
onready var u_inst = get_node("../../terra/units")
onready var unit_panel = get_node("unit_manager/national_tabs")
var unit_list # конфигурация юнитов

func _ready():
	unit_list = load("res://Assets/Configs/unit_list.gd").new().units
	for national in unit_list.keys():
		#создание раздела национальности
		var national_tab = Tabs.new()
		national_tab.set_name(national)
		unit_panel.add_child(national_tab)
		#тут просто бред
		var vbc = VBoxContainer.new()
		vbc.set_name("units")
		unit_panel.get_node(national).add_child(vbc)
		#тут вид войск
		for type in unit_list[national]:
			var label = Label.new()
			label.set_name(type)
			label.set_text(type)
			unit_panel.get_node(national+"/units").add_child(label)
			# сетка вида войск
			var grid = GridContainer.new()
			grid.set_columns(4)
			grid.set_name(label.get_name()+"_grid")
			unit_panel.get_node(national+"/units").add_child(grid)
			# создание юнитов
			for unit in unit_list[national][label.get_name()]:
				var button = Button.new()
				button.set_name(unit)
				var path_file_icon = "res://Assets/Textures/Units/" + unit + ".png"
				if File.new().file_exists(path_file_icon) != true:
					path_file_icon = "res://Assets/Textures/Units/default.png"
				button.set_button_icon(load(path_file_icon))
				button.connect("pressed", self, "_on_unit_select", [unit])
				unit_panel.get_node(national+"/units/"+grid.get_name()).add_child(button) 
	set_fixed_process(true)

func _fixed_process(delta):
	if Input.is_action_just_pressed("DT_unit_manager"):
		if is_visible():
			current_unit = null; hide()
		else: show()
	if current_unit != null and (Input.is_action_pressed("DT_unit_add")):
		if Input.is_action_just_pressed("LKM"):
			u_inst.add_unit("Timofffee", current_unit, cam.get_global_mouse_pos())  

func _on_unit_select(u):
	current_unit = u
