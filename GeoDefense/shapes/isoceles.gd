@tool
extends Shape

@export_range(0, 20, 1)  var width = 1
@export_range(0, 20, 1)  var height = 1

var points : PackedVector2Array = []

var left : Vector2 = Vector2.ZERO
var right : Vector2 = Vector2.ZERO
var center : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	center = Vector2(snapped_pos.x, snapped_pos.y - height * grid.current_frequency) 
	right = Vector2(snapped_pos.x + (width / 2) * grid.current_frequency, snapped_pos.y)
	left = Vector2(snapped_pos.x - (width / 2) * grid.current_frequency, snapped_pos.y)

func draw_shape():	
	center = Vector2(snapped_pos.x, snapped_pos.y - height * grid.current_frequency)
	right = Vector2(snapped_pos.x + (width / 2) * grid.current_frequency, snapped_pos.y)
	left = Vector2(snapped_pos.x - (width / 2) * grid.current_frequency, snapped_pos.y)
		
	points.clear()
	points.append(center)
	points.append(left)
	points.append(right)
	draw_polygon(points, PackedColorArray([draw_col, draw_col, draw_col]))

func get_area() -> float:
	return abs(width * height / 2.0)
	
func draw_guides():
	draw_guide_text(str(width), width, Vector2.LEFT * ( width / 2 + 1 )* grid.current_frequency + Vector2.UP * 0.2 * grid.current_frequency)
	draw_guide_text(str(height), width, Vector2.LEFT * ( width / 2 - 0.5)* grid.current_frequency + Vector2.UP * (height / 2 - 0.5) * grid.current_frequency)
	draw_dashed_line(snapped_pos, Vector2(snapped_pos.x, snapped_pos.y - height * grid.current_frequency), Color.BLACK, 3)

func cursor_in() -> bool:
	var is_in : bool = false
	var looker = global_position + real_pos
	if (grid.cursor_pos.x > looker.x - (width / 2) * grid.current_frequency 
	and grid.cursor_pos.y > looker.y - height * grid.current_frequency
	and grid.cursor_pos.x < looker.x + width / 2 * grid.current_frequency
	and grid.cursor_pos.y < looker.y):
		is_in = true
	return is_in
