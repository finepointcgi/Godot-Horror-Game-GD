extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_resume_button_down():
	GameManager.Pause()
	pass # Replace with function body.

func _on_load_closed():
	$Menu.show()
	

func _on_load_button_down():
	GameManager.UIManager.ShowLoadMenu()

	GameManager.UIManager.closing.connect(_on_load_closed)
	GameManager.UIManager.loading.connect(_on_loading)
#	var obj = SaveLoadManager.LoadGame("checkpoint")
#	GameManager.LoadingFromSave = true
#	GameManager.LoadLevel(obj.gamemanager.scene, obj.gamemanager.spawnIndex)
#	GameManager.Inventory.LoadInventory(obj.inventory)
	$Menu.hide()
	#hide()
	pass # Replace with function body.

func _on_loading():
	GameManager.Pause()

func _on_save_button_down():
	var s = str(Time.get_datetime_string_from_system())
	s = s.replace(":","-")
	
	SaveLoadManager.SaveGame(null, "checkpoint" + s)
	pass # Replace with function body.


func _on_options_button_down():
	pass # Replace with function body.


func _on_exit_button_down():
	get_tree().quit()
	pass # Replace with function body.

