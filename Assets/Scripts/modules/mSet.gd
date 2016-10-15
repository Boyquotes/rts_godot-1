extends Node
#Реализация множеств для Годошечки :3
var d = {}
func _init(m):	
	for i in m:	
		d[i] = 0

func intersection(b):
	var c = []
	for i in d:
		for j in b:	
			if i == j:
				c.append(i)
				break
	return c

func union(b):
	var tmp = d
	for i in b:
		tmp[i] = 0
	return tmp.keys()

func difference(b):
	var c = get_keys()
	var a = intersection(b)
	for i in c:	if i in a:	c.remove(c.find(i))
	return c

func get_keys():	
	return d.keys() 