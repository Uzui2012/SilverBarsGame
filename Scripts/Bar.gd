extends "res://Scripts/Item.gd"

var unclicked = preload("res://Assets/bar_1.png")
var clicked = preload("res://Assets/bar_2.png")
var sfx_pickup = load("res://Assets/SFX/pickup_bar_2.wav")
var sfx_putdown = load("res://Assets/SFX/putdown_bar_2.wav")

onready var engraver_sprite = get_node("BarSprite")

var sound_player := AudioStreamPlayer.new()

func _ready():
	add_child(sound_player)

func _input_event(viewport, event, shape_idx):
	
	if event is InputEventMouseButton:
		if chosen:
			engraver_sprite.set_texture(clicked)
			sound_player.stream = sfx_pickup
			sound_player.play()
			
		else:
			engraver_sprite.set_texture(unclicked)
			sound_player.stream = sfx_putdown
			sound_player.play()
	elif event is InputEventMouseMotion:
		if !mouse_in or !chosen or !dragging:
			engraver_sprite.set_texture(unclicked)
			#sound_player.stream = sfx_putdown
			#sound_player.play()

func _physics_process(delta):
	if !dragging:
		engraver_sprite.set_texture(unclicked)
