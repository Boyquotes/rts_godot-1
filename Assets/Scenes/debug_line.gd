extends Control

var queue = []
onready var lines = [get_node("1"),get_node("2"),get_node("3"),get_node("4"),get_node("5")]

func _ready():
	set_process(true)

func _process(delta):
	if queue.size() > 0:     
		for s in range (0,5):
			if lines[s].is_visible() == false:
				lines[s].set_text(str(queue[0]))
				lines[s].get_node("anim").play("hide")
				queue.remove(0)
				break