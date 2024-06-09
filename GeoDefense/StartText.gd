extends Label

@export var wave_text : WaveText

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(1.5).timeout
	text = ""
	wave_manager.increment_wave()
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
