extends Node2D

var item_stack = []

var item_scene = preload("res://Scenes/Bar.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for child in self.get_children():
		if child is KinematicBody2D:
			add_item(child)
			
func _process(delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		get_node("Camera2D").zoom_out()
			
func add_item(item):
	item_stack.append(item)
	
	var count = 0
	for i in item_stack:
		i.z_index = count
		
		count += 1
	#print(item_stack)
	
func push_item_to_top(item):
	item_stack.erase(item)
	add_item(item)
