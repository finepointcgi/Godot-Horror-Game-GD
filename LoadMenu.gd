extends Control

var saveToLoad
signal closing
signal loading
@export var saveGamePath : String
@export var loadButton : PackedScene

func _ready():
	PopulateButtons()

func PopulateButtons():
	var p = DirAccess.get_directories_at("user://savedgames")
	for i in p:
		var button : Button = loadButton.instantiate()
		button.loadButtonDown.connect(_on_load_Button_Pressed)
		var file = FileAccess.open("user://savedgames/" + i + "/" + i +  "_save.dat", FileAccess.READ)
		var content = file.get_as_text()
		var obj = JSON.parse_string(content)
		button.setUpButton(obj)
		button.text = obj.name
		$Panel2/ScrollContainer/LoadButtons.add_child(button)
	

func _on_load_Button_Pressed(date, saveName, imagePath):
	$SaveName.text  = saveName
	saveToLoad = saveName
	$SaveDate.text = date
	
	var path = OS.get_user_data_dir() + "/img.png"
	$TextureRect.texture = load_image_texture(path)
	$LoadSceneButton.disabled = false
	
	#var texture = load("usr://img.png")
	#sprite.texture = texture
	#$TextureRect.texture = texture#ResourceLoader.load("res://img.png")

func _on_back_button_down():
	hide()
	
	closing.emit()
	pass # Replace with function body.


func _on_load_scene_button_button_down():
	var obj = SaveLoadManager.LoadGame(saveToLoad)
	GameManager.LoadingFromSave = true
	GameManager.LoadLevel(obj.gamemanager.scene, obj.gamemanager.spawnIndex)
	GameManager.Inventory.LoadInventory(obj.inventory)
	closing.emit()
	loading.emit()
	queue_free()
	pass # Replace with function body.

func load_image_texture(path: String) -> ImageTexture:
		
	var loaded_image := Image.new()
	var error := loaded_image.load(path)
	
	if error != OK:
		return null

	return ImageTexture.create_from_image(loaded_image)
	

func save_image(image: Image, path: String) -> int:
		
	# Get the extension of our image
	var extension := path.get_extension().to_lower()
	
	# Recursively ensure that the directory exists
	DirAccess.make_dir_recursive_absolute(path.get_base_dir())
	
	# Based on the extension call the different saving routines
	match extension:
		"png":
			return image.save_png(path)
		"jpg", "jpeg":
			return image.save_jpg(path, 0.8)
		"webp":
			return image.save_webp(path)
	
	return 0
