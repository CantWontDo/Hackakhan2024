class_name WaveManager
extends Node

var wave_text : WaveText
var end_text : Label
var end_text_score : Label

var wave_strength : float = 1
var wave : float = 0

var waves : Array = []

var game_over = false

var wave_amount = 8

signal start_wave
# Called when the node enters the scene tree for the first time.
func _ready():
	
	wave_text = get_tree().root.get_node("Main/WaveText") as WaveText
	end_text = get_tree().root.get_node("Main/EndText") as Label
	end_text_score = get_tree().root.get_node("Main/EndTextScore") as Label
	for i in wave_amount:
		waves.append(load("res://waves/wave_" + str(i + 1) + ".tscn"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if game_over:
		end_text.text = "Game Over!"
		end_text_score.text = "You reached wave " + str(wave)
	else:
		if get_tree().get_nodes_in_group("shape").size() == 0 and wave != 0:
			emit_signal("start_wave", wave)
			increment_wave()
	pass
	
func increment_wave():
	if wave < wave_amount:
		wave += 1
		if wave != 1:
			wave_strength += 1.0 / 30
		
		wave_text.set_wave(wave)
		var wave_scene : PackedScene = waves[wave - 1] as PackedScene
		var wave_instance = wave_scene.instantiate()
		get_tree().root.get_node("Main").add_child(wave_instance)
	else:
		game_over = true
	

