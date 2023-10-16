extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$LoadMenu.LoadingLevel.connect(on_load_level)
	$LoadMenu.HideInterface.connect(on_hide_interface)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_game_button_down():
	
	GameManager.LoadLevel("res://Scenes/Level One WakeUp.tscn" , 0)
	queue_free()
	
	pass # Replace with function body.


func _on_load_game_button_down():
	$LoadMenu.show() 
	pass # Replace with function body.

func on_load_level():
	queue_free()
	
func on_hide_interface():
	$LoadMenu.hide()
