extends ColorRect

@onready var title = $title
@onready var minimize = $minimize
@onready var close = $close

func _on_resized() -> void:
	
	var x = size.x
	var y = size.y
	var button_size = Vector2(y*0.90, y*0.90)
	var position_offset = (y*0.1)
	close.size = button_size # Square
	close.position = Vector2(x - y*1.2, position_offset)
	
	minimize.size = button_size # Square
	minimize.position = Vector2(x - (y * 2.4), position_offset) 
	
	var title_width = x - (y * 2) 
	title.size = Vector2(title_width, y)
	title.position = Vector2(0, 0)

	var fs = int(y * 0.8)
	title.add_theme_font_size_override("normal_font_size", fs)
	
	
