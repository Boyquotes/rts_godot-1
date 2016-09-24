extends Control

var current_unit = null

onready var cam = get_node("../Camera2D")
onready var u_inst = get_node("../terra/units")
onready var unit_panel = get_node("unit_manager/national_tabs")
var unit_list 

func _ready():
	unit_list = load("res://Assets/Configs/unit_list.gd").new().unit
	for national in unit_list.keys():
		var national_tab = Tabs.new()
		national_tab.set_name(national)
		unit_panel.add_child(national_tab)
		var vbc = VBoxContainer.new()
		vbc.set_name("units")
		unit_panel.get_node(national).add_child(vbc)
		var label = Label.new()
		label.set_name("infantry")
		label.set_text("infantry")
		unit_panel.get_node(national+"/units").add_child(label)
		var grid = GridContainer.new()
		grid.set_name("infantry_"+"grid")
		unit_panel.get_node(national+"/units").add_child(grid)
		for unit in unit_list[national]:
			var button = Button.new()
			button.set_name(unit)
			button.set_button_icon(load("res://Assets/Textures/Units/"+unit+".png"))
			button.connect("pressed", self, "_on_unit_select", [unit])
			unit_panel.get_node(national+"/units/"+grid.get_name()).add_child(button)
			 
	set_fixed_process(true)

func _fixed_process(delta):
	if Input.is_action_just_pressed("DT_unit_manager"):
		if is_visible():
			current_unit = null
			hide()
		else:
			show()
	if current_unit != null and (Input.is_action_pressed("DT_unit_add")):
		if Input.is_action_just_pressed("LKM"):
			u_inst.add_unit("Timofffee", current_unit, cam.get_global_mouse_pos())  

func _on_unit_select(u):
	current_unit = u
