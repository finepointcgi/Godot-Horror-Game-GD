extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_game_button_down():
	get_node("StartGame").hide()
	GameManager.LoadLevel("res://Scenes/Level One WakeUp.tscn" , 0)
	queue_free()
	pass # Replace with function body.


func _on_load_game_button_down():
	GameManager.UIManager.ShowLoadMenu()

	GameManager.UIManager.currentLoadMenu.closing.connect(_on_load_closed)
	GameManager.UIManager.currentLoadMenu.loading.connect(_on_loading)
	pass # Replace with function body.
	
	
	
func _on_load_closed():
	
	pass

func _on_loading():
	queue_free()
	pass
