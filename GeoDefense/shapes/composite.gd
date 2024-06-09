extends Shape

var shapes : Array = []
# Called when the node enters the scene tree for the first time.
func _ready():
	super._ready()
	shapes = get_children()
	pass # Replace with function body.

func get_area() -> float:
	var total_area : float = 0
	for i in shapes.size():
		var shape : Shape = shapes[i] as Shape
		total_area += shape.get_area()
	return abs(total_area)

func cursor_in() -> bool:
	for i in shapes.size():
		var shape : Shape = shapes[i] as Shape
		if shape.cursor_in():
			return true
	return false

func do_penalty():
	await get_tree().create_timer(5).timeout
	selected = false
	for i in shapes.size():
		var shape : Shape = shapes[i] as Shape
		shape.selected = false
		shape.fall_speed *= 8
		
func do_select():
	selected = true
	for i in shapes.size():
		var shape : Shape = shapes[i] as Shape
		shape.selected = true
	
func do_answer():
	var guess : int = int(answer.text)
	print(guess)
	if guess == get_area() and selected:
		answer.clear()
		queue_free()
		pass
	
