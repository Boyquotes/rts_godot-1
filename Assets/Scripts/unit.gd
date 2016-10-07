extends Sprite    
# George Linkovsky - GovnoCode (2016)
export var diffuse_color_unit = Color(1,0.1,0.1)
export var select_color_unit = Color(0.1,1,0.1)
var current_color_unit = diffuse_color_unit
var select = false
var to_pos = Vector2()
var matrix_pos = Vector2()
var global_pos = Vector2()
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
var cord
var type_form = null
var tag = null

func init(player, unit_name, cord):
	var unit_conf = load("res://Assets/Configs/unit_list.gd").new()
	self.ID = player["ID"]
	self.unit_name = unit_name
	self.national = player["national"]
	for tk in unit_conf.units[self.national].keys():
		for tkk in unit_conf.units[self.national][tk].keys():
			if tkk == unit_name:
				self.type = tk
				break
		if (self.type != null): break
	self.cord = cord
	var conf_uni = unit_conf.units[self.national][self.type][self.unit_name]
	self.health = conf_uni["health"]
	self.morale = conf_uni["morale"]
	self.power = conf_uni["power"]
	self.power_speed = conf_uni["power_speed"]
	self.power_type = conf_uni["power_type"]
	self.speed = conf_uni["speed"]
	self.demoral = conf_uni["demoral"]
	

func _ready():
	set_texture(unit_manager.unit_images[unit_name])
	add_to_group("player_army")
	set_modulate(current_color_unit)
	set_process(true)
	

func _process(delta):
	if to_pos != last_pos:
		if to_pos.distance_to(last_pos) < 1:
			last_pos = to_pos
		else:
			var vec = (to_pos - get_global_pos()).normalized()
			set_global_pos(get_global_pos() + vec * speed / 2)   
			last_pos = get_global_pos()
		set_rot(get_global_pos().angle_to_point(to_pos))

		#update()
	else:
		if (get_rot() != angle and angle != null):
			set_rot(angle)  
			angle = null 



func selecting(s, l):
	var sx = false
	var sy = false
	var x = false
	var y = false
	if s.x > l.x: sx = true
	if s.y > l.y: sy = true
	if (Vector2(abs(s.x - l.x), abs(s.y - l.y)) < Vector2(10, 10) ):
		if sx:
			s.x +=8
			l.x += -8
		else:
			s.x += -8
			l.x += 8
		if sy:
			s.y += 8
			l.y += -8
		else:
			s.y += -8
			l.y += 8
	if sx:
		if get_global_pos().x > l.x and (get_global_pos().x < s.x): x = true
	else:
		if get_global_pos().x < l.x and (get_global_pos().x > s.x): x = true
	if sy:
		if get_global_pos().y > l.y and (get_global_pos().y < s.y): y = true
	else:
		if get_global_pos().y < l.y and (get_global_pos().y > s.y): y = true
	
	if x and y: 
		current_color_unit = select_color_unit
		select = true
		if not(self in unit_manager.unit_select_group): 
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