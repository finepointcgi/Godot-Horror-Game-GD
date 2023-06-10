extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_game_button_down():
	get_node("StartGame").hide()
	get_node("LoadingScreen").LoadLevel("res://Scenes/Level One WakeUp.tscn" , 0)
	pass # Replace with function body.
