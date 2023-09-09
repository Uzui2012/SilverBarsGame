extends KinematicBody2D

const momentum_scaler = 30
const drag = 0.70

var dragging_distance
var dir
var dragging
var new_position = Vector2()
var chosen_offset_up = Vector2(5,-5)
var chosen_offset_down = Vector2(-5,5)

var momentum = Vector2()

var mouse_in = false
var chosen = false

func _input(event):
	# Handling the mouse click input event - clicked or unclicked
	if event is InputEventMouseButton:
		# Given the mouse button is clicked, this paper is chosen, and the mouse is in frame?
		print("-------------")
		print("Collider ID: ", get_instance_id())
		print("chosen: ", chosen)
		print("event.is_pressed(): ", event.is_pressed())
		print("mouse_in var: ", mouse_in)
		print("-------------")
		if chosen and event.is_pressed() && mouse_in:
			# 'get_viewport()' gets the current ViewPort, that can get the current mouse position.
			var mouse_pos = get_viewport().get_mouse_position()
			
			# 'position' is the position of THIS object.
			# '.distance_to(x)' gives the distance scaler from object to x.
			# We have calculated the scaler distance between the position of the Paper and the 
			# position of the mouse.
			dragging_distance = position.distance_to(mouse_pos)
			
			# '.normalized()' is a method of a Vector2D, that provides the unit vector (direction).
			# So, here we are getting the direction between the position of the Paper and the 
			# position of the mouse.
			dir = (mouse_pos - position).normalized()
			
			# Just set our internal flag to true - yes we are dragging this current Paper.
			dragging = true
			
			# Calculate the new position by getting the difference between the current mouse 
			# position and the scaled directional vector of the current object.
			new_position = mouse_pos - dragging_distance * dir
			
			move_and_slide(position + chosen_offset_up)
			
		# Given typically the mouse is unclicked, but also when this paper is unchosen, nor the mouse is in frame?
		
		else:
			if chosen and !event.is_pressed() && mouse_in:
				move_and_slide((position + chosen_offset_down) * Vector2(-1, 1))
			dragging = false
			chosen = false
			
	elif event is InputEventMouseMotion:
		# Given the dragging flag is set to true (we are actively clicked on this paper),
		if dragging:
			# 'get_viewport()' gets the current ViewPort, that can get the current mouse position.
			var mouse_pos = get_viewport().get_mouse_position()
			new_position = mouse_pos - dragging_distance * dir
			
# Called on every physics calculation during game loop
func _physics_process(delta):
	# Given we are currently draggin this paper
	if dragging:
		# Moves the body along the input vector
		move_and_slide((chosen_offset_up + new_position  - position) * Vector2(30, 30))
		momentum = new_position  - position + chosen_offset_up
		print(momentum)
		
	else:
		move_and_slide(momentum * momentum_scaler )
		momentum = momentum * drag

func chosen():
	chosen = true

func mouse_entered():
	mouse_in = true

func mouse_exited():
	mouse_in = false

