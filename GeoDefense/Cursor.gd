
extends Node2D

var mouse_snapped : Vector2 = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if wave_manager.game_over:
		hide()
	mouse_snapped = grid.snap(get_global_mouse_position())
	grid.cursor_pos = mouse_snapped
	queue_redraw()
	
func _draw():
	draw_circle(mouse_snapped, 6 + sin(randf_range(0, 10000)), Color.WHITE)

