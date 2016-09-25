extends Sprite    
# George Linkovsky - GovnoCode (2016)
export var diffuse_color_unit = Color(1,0.1,0.1)
export var select_color_unit = Color(0.1,1,0.1)
var current_color_unit = diffuse_color_unit
var select = false
var to_pos = Vector2()
var last_pos = Vector2()
var unit_class
onready var um = get_parent()

class Unit:
	var ID
	var type = null   #	var type = "solider"
	var unit
	var health        #	var health = 12
	var morale        #	var morale = 8
	var strange       #	var strange = 14
	var strange_speed 
	var strange_type  #	var strange_type = 1
	var national      #	var national = "poland"
	var speed         #	var speed = 4
	var demoral       #var demoral = 1
	var cord
	func _init(player, unit, cord):
		var unit_conf = load ("res://Assets/Configs/unit_list.gd").new()
		self.ID = player["ID"]
		self.unit = unit
		self.national = player["national"]
		for tk in unit_conf.unit[self.national].keys():
			for tkk in unit_conf.unit[self.national][tk].keys():
				if tkk == unit:
					self.type = tk
					break
			if (self.type != null): break
		self.cord = cord
		var conf_uni = unit_conf.unit[self.national][self.type][self.unit]
		self.health = conf_uni["health"]
		self.morale = conf_uni["morale"]
		self.strange = conf_uni["strange"]
		self.strange_speed = conf_uni["strange_speed"]
		self.strange_type = conf_uni["strange_type"]
		self.speed = conf_uni["speed"]
		self.demoral = conf_uni["demoral"]

func _ready():
	add_to_group("player_army")
	set_modulate(current_color_unit)
	set_fixed_process(true)

func _fixed_process(delta):
	if to_pos != last_pos:
		if to_pos.distance_to(last_pos) < 1.0:
			last_pos = to_pos
		else:
			var vec = (to_pos - get_global_pos()).normalized()
			set_global_pos(get_global_pos() + vec * unit_class.speed/2)   
			last_pos = get_global_pos()

func selecting(s, l):
	var sx = false
	var sy = false
	var x = false
	var y = false
	if s.x > l.x: sx = true
	if s.y > l.y: sy = true
	if (Vector2(abs(s.x - l.x), abs(s.y-l.y)) < Vector2(10,10) ):
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
		if not(self in um.unit_select_group): 
			um.unit_select_group.append(self) 
	else:
		current_color_unit = diffuse_color_unit
		select = false 
		um.unit_select_group.erase(self)
	set_modulate(current_color_unit)