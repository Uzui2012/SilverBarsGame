extends "res://Scripts/Item.gd"

var unclicked = preload("res://Assets/graver_01.png")
var clicked = preload("res://Assets/graver_02.png")

onready var engraver_sprite = get_node("GraverSprite")

func _input_event(viewport, event, shape_idx):
	
	if event is InputEventMouseButton:
		if chosen:
			engraver_sprite.set_texture(clicked)

		else:
			engraver_sprite.set_texture(unclicked)
	elif event is InputEventMouseMotion:
		if !mouse_in or !chosen or !dragging:
			engraver_sprite.set_texture(unclicked)

func _physics_process(delta):
	if !dragging:
		engraver_sprite.set_texture(unclicked)

