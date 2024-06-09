@tool
extends Shape

@export_range(0, 20, 1)  var width = 1
@export_range(0, 20, 1)  var height = 1

var points : PackedVector2Array = []

var center : Vector2 = Vector2.ZERO
var point2 : Vector2 = Vector2.ZERO
var point3 : Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	center = snapped_pos
	point2 = Vector2(snapped_pos.x, snapped_pos.y - (height * grid.current_frequency))
	point3 = Vector2(snapped_pos.x + (width * grid.current_frequency), snapped_pos.y)
	pass # Replace with function body.

func draw_shape():	
	center = snapped_pos
	point2 = Vector2(snapped_pos.x, snapped_pos.y - (height * grid.current_frequency))
	point3 = Vector2(snapped_pos.x + (width * grid.current_frequency), snapped_pos.y)
		
	points.clear()
	points.append(center)
	points.append(point2)
	points.append(point3)
	draw_polygon(points, PackedColorArray([draw_col, draw_col, draw_col]))

func get_area() -> float:
	return abs(width * height / 2.0)
	
func draw_guides():
	var offset = str(height).length()
	draw_guide_text(str(width), width, Vector2.UP * 0.2 * grid.current_frequency)
	draw_guide_text(str(height), -1, 
		Vector2.UP  * grid.current_frequency + Vector2.RIGHT * 0.2 * grid.current_frequency)
	pass
	
func cursor_in() -> bool:
	var is_in : bool = false
	var looker = global_position + real_pos
	if width > 0 and height > 0:
		if (grid.cursor_pos.x > looker.x 
		and grid.cursor_pos.y < looker.y 
		and grid.cursor_pos.x < looker.x + width * grid.current_frequency
		and grid.cursor_pos.y > looker.y - height * grid.current_frequency):
			is_in = true
		if (grid.cursor_pos.x < looker.x 
		and grid.cursor_pos.y > looker.y 
		and grid.cursor_pos.x > looker.x + width * grid.current_frequency
		and grid.cursor_pos.y < looker.y - height * grid.current_frequency):
			is_in = true
	return is_in
