extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$LoadMenu.LoadingLevel.connect(on_load_level)
	$LoadMenu.HideInterface.connect(on_hide_interface)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_load_level():
	queue_free()
	
func on_hide_interface():
	$LoadMenu.hide()


func _on_resume_button_down():
	GameManager.UnpauseGame()
	pass # Replace with function body.


func _on_save_button_down():
	var date = str(Time.get_datetime_string_from_system())
	date = date.replace(":", "-")

	SaveLoadManager.SaveGame("test-"+ date)
	pass # Replace with function body.


func _on_load_button_down():
	$LoadMenu.show()
	
	pass # Replace with function body.


func _on_settings_button_down():
	pass # Replace with function body.


func _on_exit_button_down():
	get_tree().quit()
	pass # Replace with function body.
