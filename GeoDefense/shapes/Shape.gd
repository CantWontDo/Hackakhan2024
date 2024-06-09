@tool
class_name Shape
extends Node2D

var real_pos : Vector2 = position
@onready var offset = abs(global_position.y)
var snapped_pos : Vector2 

@export var shape_col : Color = Color.WHITE
@export var selected_col : Color = Color.BLACK

var draw_col : Color = Color.WHITE
@export var fall_speed = 10

var true_fall_speed

var button
var answer

var selected : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	print(offset)
	fall_speed = 100
	if shape_col == Color.WHITE:
		shape_col = Color(randf(), randf(), randf())
	if not Engine.is_editor_hint():
		snapped_pos = grid.snap(real_pos)
		button = get_tree().root.get_node("Main").get_node("AnswerBox/AnswerButton") as Button 
		answer = get_tree().root.get_node("Main").get_node("AnswerBox") as LineEdit
		button.connect("pressed", do_answer)
	else:
		snapped_pos = real_pos


func _physics_process(delta):
	if not Engine.is_editor_hint():
		true_fall_speed = fall_speed * pow(wave_manager.wave_strength, wave_manager.wave)
		real_pos.y += true_fall_speed * delta
		if (snapped_pos.y - offset) > get_viewport_rect().size.y:
			print(snapped_pos.y - offset)
			print(get_viewport_rect().size.y)
			print(name)
			wave_manager.game_over = true
		if wave_manager.game_over:
			fall_speed = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		selected = false
	if selected:
		draw_col = selected_col
	else:
		draw_col = shape_col
	if not Engine.is_editor_hint():
		snapped_pos = grid.snap(real_pos)
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and cursor_in() and (not selected) and not wave_manager.game_over:
			do_select()
			do_penalty()
		if Input.is_action_just_pressed("ui_select"):
			do_answer()
	queue_redraw()
	pass
	
func _draw():
	draw_shape()
	draw_guides()
	pass
	
func draw_shape():
	pass

func draw_guides():
	pass

func get_area() -> float:
	return 0
	pass

func cursor_in() -> bool:
	return true

func do_penalty():
	await get_tree().create_timer(5).timeout
	if selected:
		fall_speed *= 8
	selected = false

func do_select():
	selected = true

func do_answer():
	var guess : int = int(answer.text)
	if guess == get_area() and selected:
		answer.clear()
		queue_free()
		pass
	
func draw_guide_text(text : String, width, offset : Vector2):
	draw_string(ThemeDB.fallback_font, snapped_pos + offset, str(text), HORIZONTAL_ALIGNMENT_CENTER, width * grid.current_frequency, 24, Color.WHITE)
	draw_string_outline(ThemeDB.fallback_font, snapped_pos + offset, str(text), HORIZONTAL_ALIGNMENT_CENTER, width * grid.current_frequency, 24, 2, Color.BLACK)
