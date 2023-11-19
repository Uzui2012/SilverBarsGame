extends Area2D

var time = 0

func _ready():
	pass
	
func _process(delta):
	time = time + 1
	position = get_global_mouse_position()
	var count = len(get_overlapping_bodies())
	
	if (count == 0):
		pass
	elif (count == 1):
		get_overlapping_bodies()[0].chosen()
		if (Input.is_action_just_pressed("mouse_click")):
			get_parent().push_item_to_top(get_overlapping_bodies()[0])

	else:
		var max_index = -1
		var top_item = null

		for b in get_overlapping_bodies():
			if (b.z_index > max_index):
				max_index = b.z_index
				top_item = b

		top_item.chosen()
		for b in get_overlapping_bodies():
			if b != top_item:
				b.chosen = false

		if (Input.is_action_just_pressed("mouse_click")):
			get_parent().push_item_to_top(top_item)

		if (Input.is_action_just_released("mouse_click")):
			var covered_item = null
			
			var temp_idx = -1
			for b in get_overlapping_bodies():
				if (b.z_index < get_parent().item_stack[-1].z_index):
					if(b.z_index > temp_idx):
						temp_idx = b.z_index
						covered_item = b

			if top_item.name == "Engraver":
				get_parent().get_node("Camera2D").zoom_on(covered_item)
