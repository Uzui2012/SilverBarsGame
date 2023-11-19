extends Camera2D

var default_pos

func _ready():
	default_pos = self.position

func _process(delta):
	pass

func zoom_on(item):
	print(item)
	print(item.position)
	self.position = item.position
	
	
func zoom_out():
	self.position = default_pos
