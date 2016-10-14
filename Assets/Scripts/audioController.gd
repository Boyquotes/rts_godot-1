extends Node

var channel_list = {}

func _ready():
	channel_list[0] = {	"name":"main","vol":"1.0","nodes":[]}

func add_channel (id, name, vol = 1.0, nodes = []):
	if (channel_list.has(id)):	print ("OOPS! Audio channel "+id+" is already created...")
	else:	channel_list[id] = {"name":name,"vol":vol,"nodes":nodes}

func add_node (node, id):
	if(channel_list[id]["nodes"].has(node)):	print ("Sorry, but node ''"+node+"''already append...")
	else:	channel_list[id]["nodes"].append(node)
	update_channel(id)

func update_channel(idx):
	for n in channel_list[idx]["nodes"]:
		if (n.get_type() == "StreamPlayer"):	n.set_volume(channel_list[idx].vol)
		elif (n.get_type() == "SamplePlayer"):	n.set_default_volume(channel_list[idx].vol)