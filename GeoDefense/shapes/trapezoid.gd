@tool
extends Shape

@export_range(0, 20, 1)  var top_length = 10
@export_range(0, 20, 1) var bottom_length = 20
@export_range(0, 20, 1) var height = 10

var points : PackedVector2Array = []

var top_left : Vector2 = Vector2.ZERO
var top_right : Vector2 = Vector2.ZERO
var bottom_left : Vector2 = Vector2.ZERO
var bottom_right : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	top_left = Vector2(snapped_pos.x - (top_length / 2) * grid.current_frequency, snapped_pos.y)
	top_right = Vector2(snapped_pos.x + (top_length / 2) * grid.current_frequency, snapped_pos.y)
	
	bottom_left = Vector2(snapped_pos.x - (bottom_length / 2) * grid.current_frequency, snapped_pos.y + height * grid.current_frequency)
	bottom_right = Vector2(snapped_pos.x + (bottom_length / 2) * grid.current_frequency, snapped_pos.y + height * grid.current_frequency)
	pass # Replace with function body.

func draw_shape():
	top_left = Vector2(snapped_pos.x - (top_length / 2) * grid.current_frequency, snapped_pos.y)
	top_right = Vector2(snapped_pos.x + (top_length / 2) * grid.current_frequency, snapped_pos.y)
	
	bottom_left = Vector2(snapped_pos.x - (bottom_length / 2) * grid.current_frequency, snapped_pos.y + height * grid.current_frequency)
	bottom_right = Vector2(snapped_pos.x + (bottom_length / 2) * grid.current_frequency, snapped_pos.y + height * grid.current_frequency)
	
	points.clear()
	points.append(top_left)
	points.append(top_right)
	points.append(bottom_right)
	points.append(bottom_left)
	
	draw_polygon(points, PackedColorArray([draw_col, draw_col, draw_col, draw_col]))
	
func draw_guides():
	var offset = str(height).length()
	draw_guide_text(str(top_length), top_length, Vector2.DOWN  * 1.2 * grid.current_frequency + (Vector2.LEFT * top_length / 2 * grid.current_frequency)
		+ (Vector2.RIGHT * grid.current_frequency))
	draw_guide_text(str(height), bottom_length, 
		(Vector2.DOWN * (height / 2 + 0.5) * grid.current_frequency)
			+ (Vector2.LEFT * bottom_length / 2 * grid.current_frequency)
			+ (Vector2.RIGHT * grid.current_frequency))
	draw_dashed_line(snapped_pos, Vector2(snapped_pos.x, snapped_pos.y + (height) * grid.current_frequency), Color.BLACK, 3)
	draw_guide_text(str(bottom_length), bottom_length,
		(Vector2.DOWN * (height) * grid.current_frequency)
			+ Vector2.UP * 0.3 * grid.current_frequency
			+ (Vector2.LEFT * bottom_length / 2 * grid.current_frequency)
			+ (Vector2.RIGHT * grid.current_frequency))
	pass
	
func get_area() -> float:
	return (top_length + bottom_length) * height / 2.0

func cursor_in() -> bool:
	var is_in : bool = false
	var looker = global_position + real_pos
	if bottom_length > 0 and top_length > 0 and height > 0:
		if (grid.cursor_pos.x > looker.x - ((bottom_length / 2) * grid.current_frequency)
		and grid.cursor_pos.y > looker.y 
		and grid.cursor_pos.x < looker.x + ((bottom_length / 2) * grid.current_frequency)
		and grid.cursor_pos.y < looker.y + height * grid.current_frequency):
			is_in = true
	return is_in
