@tool
extends Shape

@export_range(0, 20, 1)  var width : float = 1
@export_range(0, 20, 1)  var height : float = 1

	
func draw_shape():	
	draw_rect(Rect2(snapped_pos, Vector2(width, height) * grid.current_frequency), draw_col)

func get_area() -> float:
	return abs(width * height)
	
func draw_guides():
	var offset = str(height).length()
	draw_guide_text(str(width), width, Vector2.DOWN  * grid.current_frequency)
	draw_guide_text(str(height), -1, 
		(Vector2.DOWN * (height / 2 + 0.5) * grid.current_frequency))
	pass


func cursor_in() -> bool:
	var is_in : bool = false
	var looker = global_position + real_pos
	if width > 0 and height > 0:
		if (grid.cursor_pos.x > looker.x 
		and grid.cursor_pos.y > looker.y 
		and grid.cursor_pos.x < looker.x + width * grid.current_frequency
		and grid.cursor_pos.y < looker.y + height * grid.current_frequency):
			is_in = true
	return is_in
