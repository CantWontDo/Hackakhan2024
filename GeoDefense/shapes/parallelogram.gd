@tool
extends Shape

@export_range(0, 20, 1) var length = 10
@export_range(0, 20, 1)  var v_offset = 10
@export_range(0, 20, 1)  var h_offset = 10

var points : PackedVector2Array = []

var top_left : Vector2 = Vector2.ZERO
var top_right : Vector2 = Vector2.ZERO
var bottom_left : Vector2 = Vector2.ZERO
var bottom_right : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	top_left = Vector2(snapped_pos.x, snapped_pos.y)
	top_right = Vector2(snapped_pos.x + length * grid.current_frequency, snapped_pos.y)
	
	bottom_left = Vector2(snapped_pos.x + h_offset * grid.current_frequency, snapped_pos.y + v_offset * grid.current_frequency)
	bottom_right = Vector2(snapped_pos.x + (h_offset + length) * grid.current_frequency, snapped_pos.y+ v_offset * grid.current_frequency)
	
	pass # Replace with function body.

func draw_shape():
	top_left = Vector2(snapped_pos.x, snapped_pos.y)
	top_right = Vector2(snapped_pos.x + length * grid.current_frequency, snapped_pos.y)
	
	bottom_left = Vector2(snapped_pos.x + h_offset * grid.current_frequency, snapped_pos.y + v_offset * grid.current_frequency)
	bottom_right = Vector2(snapped_pos.x + (h_offset + length) * grid.current_frequency, snapped_pos.y+ v_offset * grid.current_frequency)
	
	points.clear()
	points.append(top_left)
	points.append(top_right)
	points.append(bottom_right)
	points.append(bottom_left)
	
	draw_polygon(points, PackedColorArray([draw_col, draw_col, draw_col, draw_col]))

func get_area() -> float:
	return abs(length * v_offset)

func draw_guides():
	draw_guide_text(str(length), length + h_offset, Vector2.DOWN * v_offset * grid.current_frequency)
	draw_guide_text(str(v_offset), length, 
		Vector2.DOWN * 2 * grid.current_frequency + Vector2.RIGHT * 0.2 * grid.current_frequency)
	draw_dashed_line(Vector2(snapped_pos.x + length / 2 * grid.current_frequency + grid.current_frequency * 1.4, snapped_pos.y),
		 Vector2(snapped_pos.x + length / 2 * grid.current_frequency + grid.current_frequency * 1.4, snapped_pos.y + v_offset * grid.current_frequency), Color.BLACK, 3)
	pass
	
func cursor_in() -> bool:
	var is_in : bool = false
	var looker = global_position + real_pos
	if length > 0 and v_offset > 0 and h_offset > 0:
		if (grid.cursor_pos.x > looker.x 
		and grid.cursor_pos.y > looker.y 
		and grid.cursor_pos.x < looker.x + (length + h_offset) * grid.current_frequency
		and grid.cursor_pos.y < looker.y + v_offset * grid.current_frequency):
			is_in = true
	return is_in
