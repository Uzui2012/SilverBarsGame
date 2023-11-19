extends KinematicBody2D

const momentum_scaler = 30
const drag = 0.70

var dragging_distance
var dir
var dragging
var new_position = Vector2()

var momentum = Vector2()

var offset = Vector2(400,-700)
var onset = Vector2(-400,700)

var mouse_in = false
var chosen = false

func round_vec_to_dec(vec, digit):
	return Vector2(round(vec.x * pow(10.0, digit)) / pow(10.0, digit), round(vec.y * pow(10.0, digit)) / pow(10.0, digit) ) 

func _input(event):
	# Handling the mouse click input event - clicked or unclicked
	if event is InputEventMouseButton:
		# Given the mouse button is clicked, this item is chosen, and the mouse is in frame?
		#print("-------------")
		#print("Collider ID: ", get_instance_id())
		#print("chosen: ", chosen)
		#print("event.is_pressed(): ", event.is_pressed())
		#print("mouse_in var: ", mouse_in)
		#print("-------------")
		if chosen and event.is_pressed() and mouse_in and event.button_index == BUTTON_LEFT:
			move_and_slide(offset*0.7)
			# 'get_viewport()' gets the current ViewPort, that can get the current mouse position.
			var mouse_pos = get_viewport().get_mouse_position()
			# 'position' is the position of THIS object.
			# '.distance_to(x)' gives the distance scaler from object to x.
			# We have calculated the scaler distance between the position of the Item and the 
			# position of the mouse.
			dragging_distance = position.distance_to(mouse_pos)
			# '.normalized()' is a method of a Vector2D, that provides the unit vector (direction).
			# So, here we are getting the direction between the position of the Item and the 
			# position of the mouse.
			dir = (mouse_pos - position).normalized()
			# Just set our internal flag to true - yes we are dragging this current Item.
			dragging = true
			# Calculate the new position by getting the difference between the current mouse 
			# position and the scaled directional vector of the current object.
			new_position = mouse_pos - dragging_distance * dir
			
		# Given typically the mouse is unclicked, but also when this item is unchosen, nor the mouse is in frame?
		else:
			if event.button_index == BUTTON_LEFT:
				if chosen and !event.is_pressed() and mouse_in:
					move_and_slide(onset*0.7)
				dragging = false
				chosen = false
			
	elif event is InputEventMouseMotion:
		# Given the dragging flag is set to true (we are actively clicked on this item),
		if dragging:
			# 'get_viewport()' gets the current ViewPort, that can get the current mouse position.
			var mouse_pos = get_viewport().get_mouse_position()
			new_position = mouse_pos - dragging_distance * dir
			
# Called on every physics calculation during game loop
func _physics_process(delta):
	# Given we are currently draggin this item
	if dragging:
		# Moves the body along the input vector
		move_and_slide((new_position  - position) * Vector2(30, 30))
		#move_and_slide((new_position  - position) )
		momentum = new_position  - position #+ chosen_offset_up
		#print(momentum)
	# We've let go of the item	
	else:
		move_and_slide(momentum * momentum_scaler )
		momentum = momentum * drag

func chosen():
	chosen = true

func mouse_entered():
	mouse_in = true

func mouse_exited():
	mouse_in = false

