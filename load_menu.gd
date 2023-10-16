extends Control

@export var LoadButton : PackedScene
var saveToLoad

signal LoadingLevel
signal HideInterface
# Called when the node enters the scene tree for the first time.
func _ready():
	var dir = DirAccess.get_directories_at("user://savedGames")
	for i in dir:
		var button : Button = LoadButton.instantiate()
		button.LoadButtonDown.connect(OnLoadButtonDown)
		
		var file = FileAccess.open("user://savedGames/" + i + "/" +i + "_saveGame.json", FileAccess.READ)
		var content = file.get_as_text()
		var obj = JSON.parse_string(content)
		button.SetupButton(obj)
		button.text = obj.name
		$Panel/ScrollContainer/LoadButtons.add_child(button)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func OnLoadButtonDown(date, saveName, imagePath):
	$SaveName.text = saveName
	$SaveDate.text = date
	saveToLoad = saveName
	$TextureRect.texture =  LoadImageTexture(imagePath)
	
	#$TextureRect.texture 
	pass

func LoadImageTexture(path : String):
	var loadedImage = Image.new()
	var error = loadedImage.load(path)
	
	if error != OK:
		print("image failed to load")
		return 
	return ImageTexture.create_from_image(loadedImage)


func _on_load_scene_button_button_down():
	var obj = SaveLoadManager.LoadGame(saveToLoad)
	GameManager.LoadingFromSave = true
	GameManager.LoadLevel(obj.gamemanager.scene, obj.gamemanager.spawnIndex)
	LoadingLevel.emit()
	queue_free()
	pass # Replace with function body.


func _on_back_button_down():
	HideInterface.emit()
	pass # Replace with function body.
