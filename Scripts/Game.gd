extends Node2D

var item_stack = []

var item_scene = preload("res://Scenes/Bar.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(0, 2):
		var item = item_scene.instance()
		add_item(item)

func add_item(item):
	item_stack.append(item)
	
	var count = 0
	for i in item_stack:
		i.z_index = count
		
		count += 1

func push_item_to_top(item):
	item_stack.erase(item)
	add_item(item)
