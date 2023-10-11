extends Button

var saveName
var date
var imagePath

signal loadButtonDown(date, saveName, imagePath)

func setUpButton(data):
	saveName = data.name
	date = Time.get_datetime_string_from_unix_time(data.dateTime)
	imagePath = data.imgPath

func _on_button_down():
	loadButtonDown.emit(date, saveName, imagePath)
	#SaveLoadManager.LoadGame(saveName)
	pass # Replace with function body.
