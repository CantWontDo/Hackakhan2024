@tool
class_name Grid
extends Node2D

@export var width = 1080
@export var height = 720
@export var current_frequency = 20

var cursor_pos : Vector2 = Vector2.ZERO

func snap(world_pos : Vector2, offset = Vector2(0, 0)) -> Vector2:
	return (world_pos / current_frequency).floor() * current_frequency + offset

# Called when the node enters the scene tree for the first time.
func _ready():
	if not Engine.is_editor_hint():
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	pass
	
func _process(delta):
	
	if not Engine.is_editor_hint():
		queue_redraw()
	
func _draw():
	if not Engine.is_editor_hint():
		draw_grid()

func draw_grid():
	if not Engine.is_editor_hint():
		for i in range((width / current_frequency) + 1):
			if i % 2 == 0:
				draw_dashed_line(Vector2((i) * current_frequency, 0.0), Vector2((i) * current_frequency, height), Color.BLACK, 1)
			else:
				draw_line(Vector2((i) * current_frequency, 0.0), Vector2((i) * current_frequency, height), Color.BLACK, .5)
		for j in range((height / current_frequency) + 1):
			if j % 2 == 0:
				draw_dashed_line(Vector2(0, (j) * current_frequency), Vector2(width, (j) * current_frequency), Color.BLACK, 1)
			else:
				draw_line(Vector2(0, (j) * current_frequency), Vector2(width, (j) * current_frequency), Color.BLACK, .5)
			
		draw_line(Vector2(0, height / 2 + (height / 6)), Vector2(width, height / 2 + (height / 6)), Color.BLACK, 2)
		draw_line(Vector2(width / 2, 0), Vector2(width / 2, height), Color.BLACK, 2)	
