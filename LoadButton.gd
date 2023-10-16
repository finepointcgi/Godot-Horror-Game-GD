extends Button

var SaveName
var Date
var ImagePath

signal LoadButtonDown(date, saveName, imagePath)


func SetupButton(data):
	SaveName = data.name
	Date = Time.get_datetime_string_from_unix_time(data.dateTime)
	ImagePath = data.imgPath
	

func _on_button_down():
	LoadButtonDown.emit(Date, SaveName, ImagePath)
	pass # Replace with function body.
