extends LineEdit

@onready var regex = RegEx.new()
var old_text = ""
# Called when the node enters the scene tree for the first time.
func _ready():
	regex.compile("^[0-9.]*$")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if wave_manager.game_over:
		hide()
	grab_focus()
	pass

func _on_text_changed(new_text):
	if regex.search(new_text):
		old_text = str(new_text)
	else:
		text = old_text
		caret_column = text.length()
