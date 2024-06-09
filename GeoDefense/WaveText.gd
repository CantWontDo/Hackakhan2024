class_name WaveText
extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if text != "":
		await get_tree().create_timer(1.5).timeout
		text = ""
	if wave_manager.game_over:
		hide()
	pass

func set_wave(wave_num):
	text = "Wave " + str(wave_num)
