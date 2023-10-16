extends Node

var LoadedGame : String
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func SaveGame(name):
	var dir = DirAccess.open("user://")
	if !dir.dir_exists("savedGames"):
		dir.make_dir("savedGames")
	dir = DirAccess.open("user://savedGames")
	if !dir.dir_exists(name):
		dir.make_dir(name)
	
	var saveData = {
		"gamemanager":{
			"scene" : GameManager.LoadedLevel,
			"spawnIndex" : GameManager.SpawnIndex
		}
	}
	
	
	var saveJson = JSON.stringify(saveData)
	
	var file = FileAccess.open("user://savedGames/" + name + "/" + name +  ".json", FileAccess.WRITE)
	file.store_string(saveJson)
	
	var saveGameInfo = {
		"name" : name,
		"imgPath" : "user://savedGames/" + name + "/" + name +  ".png",
		"dateTime" : Time.get_unix_time_from_system()
	}
	
	var saveGameJson = JSON.stringify(saveGameInfo)
	
	var saveGameFile = FileAccess.open("user://savedGames/" + name + "/" + name +  "_saveGame.json", FileAccess.WRITE)
	saveGameFile.store_string(saveGameJson)
	
	
	GameManager.UIManager.HideUI()
	
	await get_tree().physics_frame
	await get_tree().physics_frame
	await get_tree().physics_frame
	await get_tree().physics_frame
	await get_tree().physics_frame
	
	var screenshot = get_viewport().get_texture().get_image()
	
	screenshot.save_png("user://savedGames/" + name + "/" + name +  ".png")
	
	
	var objs = {}
	for i in get_tree().get_nodes_in_group("Saveable"):
		objs[i.name] = i.Save()
	var sceneObjects = {
		"objs" : objs
	}
	
	var sceneJson = JSON.stringify(objs)
	
	var sceneFile = FileAccess.open("user://savedGames/" + name + "/" + name +  "_scene.json", FileAccess.WRITE)
	sceneFile.store_string(sceneJson)
	
	LoadedGame = name
	
	GameManager.UnpauseGame()


func LoadGame(name):
	LoadedGame = name
	var file = FileAccess.open("user://savedGames/" + name + "/" + name + ".json", FileAccess.READ)
	var content = file.get_as_text()
	var obj = JSON.parse_string(content)
	return obj

func LoadSceneData():
	var file = FileAccess.open("user://savedGames/" + LoadedGame + "/" + LoadedGame + "_scene.json", FileAccess.READ)
	var content = file.get_as_text()
	var obj = JSON.parse_string(content)
	return obj
