extends Node

#var playerList = {"Timofffee" : {
#						"ID":0, 
#						"national":"Random",
#						"type_player":"human"}
#				  "AI1" : {
#						"ID":1, 
#						"national":"Random",
#						"type_player":"ai"}
#				}
var player_list = {}
				
func _ready():
	add_player('Timofffee', 'human', 'Poland')
	add_player('ai1', 'ai', 'Poland')
	print (player_list)
	
func add_player(name, type, national):
	player_list[name] = {'ID' : player_list.size(), "national" : national, 'type_player' : type}
