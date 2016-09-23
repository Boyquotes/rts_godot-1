extends Sprite    
# George Linkovsky - GovnoCode (2016)
export var diffuse_color_unit = Color(1,0.1,0.1)
export var select_color_unit = Color(0.1,1,0.1)
var current_color_unit = diffuse_color_unit


class Unit:
	
#	var type = "solider"
#	var health = 12
#	var morale = 8
#	var strange = 14
#	var strange_type = 1
#	var national = "poland"
#	var speed = 4
#	var demoral = 1
	var ID
	var type
	var health 
	var morale
	var strange
	var strange_speed
	var strange_type
	var national
	var speed
	var demoral
	var cord
	func _init(player, type, cord):
		var unit_conf = load ("res://Assets/configs/unit_list.gd").new()
		self.ID = player["ID"]
		self.type = type
		self.national = player["national"]
		self.cord = cord
		var conf_uni = unit_conf.unit[self.national][self.type]
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
	
	if x and y: current_color_unit = select_color_unit
	else: current_color_unit = diffuse_color_unit
	set_modulate(current_color_unit)