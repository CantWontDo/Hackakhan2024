@tool
extends Shape

@export_range(0, 20, 1)  var length = 1.0
	
func draw_shape():
	draw_rect(Rect2(snapped_pos, Vector2(length, length) * grid.current_frequency), draw_col)

func draw_guides():
	draw_guide_text(str(length), length, Vector2.DOWN * 1.2 * grid.current_frequency)
	draw_guide_text(str(length), -1, 
		(Vector2.DOWN * (length / 2 + 0.5)* grid.current_frequency) + Vector2.RIGHT * 0.2 * grid.current_frequency)
	pass

func get_area() -> float:
	return length * length
	
func cursor_in() -> bool:
	var is_in : bool = false
	var looker = global_position + real_pos
	if length > 0:
		if (grid.cursor_pos.x > looker.x 
		and grid.cursor_pos.y > looker.y 
		and grid.cursor_pos.x < looker.x + length * grid.current_frequency
		and grid.cursor_pos.y < looker.y + length * grid.current_frequency):
			is_in = true
	return is_in


