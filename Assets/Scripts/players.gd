extends Node

var playerList = {}
#var playerList = {"Timofffee" : {
#						"ID":0, 
#						"national":"Random",
#						"type_player":"human"}
#				  "AI1" : {
#						"ID":1, 
#						"national":"Random",
#						"type_player":"ai"}
#				}
				
func _ready():
	add_player('Timofffee', 'human', 'Poland')
	add_player('ai1', 'ai', 'Poland')
	print (playerList)
	
func add_player(name, type, national):
	playerList[name] = {'ID':playerList.size(), "national":national, 'type_player':type}
