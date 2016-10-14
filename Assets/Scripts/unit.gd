extends Sprite    
# George Linkovsky - GovnoCode (2016)
export var diffuse_color_unit = Color(1,0.1,0.1)
export var select_color_unit = Color(0.1,1,0.1)
var current_color_unit = diffuse_color_unit
var select = false
var to_pos = Vector2()
var matrix_pos = Vector2()
var global_pos = Vector2()
var vec = Vector2()
var last_pos = Vector2()
#var unit_obj
onready var unit_manager = get_parent()


var path_file_icon
var angle = null

var ID
var type = null   #	var type = "solider"
var unit_name
var health        #	var health = 12
var morale        #	var morale = 8
var power        #	var strange = 14
var power_speed 
var power_type  #	var strange_type = 1
var national      #	var national = "poland"
var speed         #	var speed = 4
var demoral       #var demoral = 1
var coord
var type_form = null
var tag = null

func init(player, name, cord):
	var unit_conf = load("res://Assets/Configs/unit_list.gd").new()
	ID = player["ID"]
	unit_name = name
	national = player["national"]
	for tk in unit_conf.units[national].keys():
		for tkk in unit_conf.units[national][tk].keys():
			if tkk == unit_name:
				type = tk
				break
		if (type != null): break
	coord = cord
	var conf_uni = unit_conf.units[national][type][unit_name]
	health = conf_uni["health"]
	morale = conf_uni["morale"]
	power = conf_uni["power"]
	power_speed = conf_uni["power_speed"]
	power_type = conf_uni["power_type"]
	speed = conf_uni["speed"]
	demoral = conf_uni["demoral"]
	
func _ready():
	set_texture(unit_manager.unit_images[unit_name])
	add_to_group("player_army")
	set_modulate(current_color_unit)
	set_process(true)
	
func _process(delta):
	if ((to_pos != last_pos)):
		if to_pos.distance_to(last_pos) < 1:	last_pos = to_pos
		else:
			if to_pos.x > 0 and to_pos.y > 0:	translate(vec * speed / 2)
			last_pos = get_global_pos()
		set_rot(get_global_pos().angle_to_point(to_pos))
	elif (get_rot() != angle and angle != null):
		set_rot(angle)  
		angle = null 



func selecting(s, l):
	var one_select_unit = false
	var only_one = false
	var sx = false
	var sy = false
	var x = false
	var y = false
	if s.x > l.x: sx = true
	if s.y > l.y: sy = true
	if (Vector2(abs(s.x - l.x), abs(s.y - l.y)) < Vector2(10, 10) ):
		only_one = true
		if sx:	s.x +=4;	l.x += -4
		else:	s.x += -4;	l.x += 4
		if sy:	s.y += 4;	l.y += -4
		else:	s.y += -4;	l.y += 4
	if sx:	if get_global_pos().x > l.x and (get_global_pos().x < s.x): x = true
	else:	if get_global_pos().x < l.x and (get_global_pos().x > s.x): x = true
	if sy:	if get_global_pos().y > l.y and (get_global_pos().y < s.y): y = true
	else:	if get_global_pos().y < l.y and (get_global_pos().y > s.y): y = true
	
	if x and y: 	if (only_one):	one_select_unit = true
		select = true
		if not(self in unit_manager.unit_select_group): 
			if one_select_unit : 
				if unit_manager.unit_select_group.size() < 1: 
					current_color_unit = select_color_unit
					unit_manager.unit_select_group.append(self) 
			else:
				current_color_unit = select_color_unit
				unit_manager.unit_select_group.append(self) 
	else:
		current_color_unit = diffuse_color_unit
		select = false 
		unit_manager.unit_select_group.erase(self)
	set_modulate(current_color_unit)

func unselect():
	current_color_unit = diffuse_color_unit
	set_modulate(current_color_unit)
	select = false
	update()
	unit_manager.unit_select_group = []

func dead():
	randomize()
	remove_from_group("player_army")
	last_pos = to_pos
	get_node("anim").play("dead")
	get_node("sound").set_default_pitch_scale(1.05-((randi()%10)*0.01))
	get_node("sound").play("dead_000"+str((randi()%3) +1))