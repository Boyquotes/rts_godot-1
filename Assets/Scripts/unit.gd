extends Sprite    
# George Linkovsky - GovnoCode (2016)

func _ready():
	add_to_group("solider")
	set_modulate(currentColorUnit)

var diffuseColorUnit = Color (1,0.1,0.1)
var selectColorUnit = Color (0.1,1,0.1)
var currentColorUnit = diffuseColorUnit
	
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
	
	if x and y: currentColorUnit = selectColorUnit
	else: currentColorUnit = diffuseColorUnit
	set_modulate(currentColorUnit)