extends ColorRect

@onready var label = $label
@onready var content = $Control
@onready var title = $label/title

# size constraints
func _on_resized():
	var x = size.x
	
	var label_y = x * 0.04
	var border_size = x * 0.02
	
	var target_content_width = x - border_size
	
	var target_content_height = (target_content_width * 3) / 5
	
	content.size = Vector2(target_content_width, target_content_height)
	content.position = Vector2(border_size / 2, label_y + border_size / 2)
	
	var total_height = label_y + target_content_height + (border_size / 2) + (border_size / 2)
	
	# This line "snaps" the window to the correct height
	size.y = total_height 
	
	# Keep the header matching the width
	label.size = Vector2(x, label_y)
	
func set_content(new_scene: PackedScene):
	
	for child in content.get_children():
		child.queue_free() 
	
	var new_content = new_scene.instantiate()
	
	content.add_child(new_content)

func add_content(new_scene: PackedScene):
	
	var new_content = new_scene.instantiate()
	
	content.add_child(new_content)
	
func set_title(new_title: String):
	title.text = new_title
