extends Node

var PlayerCrouched 
var PlayerLocation
var PlayerRotation
var LoadedGame
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func SaveGame(obj, name):
	
	var dir = DirAccess.open("user://")
	if !dir.dir_exists("savedgames"):
		dir.makedir("savedgames")
	dir = DirAccess.open("user://savedgames")
	if !dir.dir_exists(name):
		dir.make_dir(name)
	
	var save_data = {
		"gamemanager":{
			"scene" : GameManager.loadedLevel,
			"spawnIndex" : GameManager.spawnIndex
		},
		"player_crouched": GameManager.Player.crouched,
		"player_location" : var_to_str(GameManager.Player.global_position),
		"player_rotation" : var_to_str(GameManager.Player.rotation_degrees),
		"inventory": GameManager.Inventory.SaveInventory(),
	}
	var save_json = JSON.stringify(save_data)
	var file = FileAccess.open("user://savedgames/"+ name +"/" + name +  ".dat", FileAccess.WRITE)
	print(FileAccess.get_open_error())
	file.store_string(save_json)

	var save_scene_data = {
		
		"enemies" : saveEnemies(),
		"sceneObjects" : saveSceneObjects()
	}
	var save_json2 = JSON.stringify(save_scene_data)
	var file2 = FileAccess.open("user://savedgames/" + name +"/" + name +  "_scene.dat", FileAccess.WRITE)
	file2.store_string(save_json2)
	
	var saveGameInfo = {
		
		"name" : name,
		"imgPath": "user://savedgames/" + name +"/" + name +  "_save.png",
		"dateTime" : Time.get_unix_time_from_system()
	}
	var save_json3 = JSON.stringify(saveGameInfo)
	var file3 = FileAccess.open("user://savedgames/" + name +"/" + name +  "_save.dat", FileAccess.WRITE)
	file3.store_string(save_json3)
	
	GameManager.UIManager.HideUI()
	
	await get_tree().physics_frame
	await get_tree().physics_frame
	await get_tree().physics_frame
	await get_tree().physics_frame
	await get_tree().physics_frame

	var screenshot = get_viewport().get_texture().get_image()
	#screenshot.flip_y()  # The image is flipped vertically, so we need to flip it back
	screenshot.save_png("user://savedgames/" + name +"/" + name +  ".png")
	#GameManager.UIManager.
	GameManager.Pause()
	

func saveSceneObjects() -> Dictionary:
	var objects = {}
	for i in get_tree().get_nodes_in_group("Saveable"):
		objects[i.name] = i.Save()
	return objects
		

func saveEnemies() -> Array:
	var enemies = []
	for i in get_tree().get_nodes_in_group("Enemy"):
		enemies.append(i.SaveEnemy())
	return enemies

func loadEnemies(data : Array):
	for i in data:
		for enemy in get_tree().get_nodes_in_group("Enemy"):
			if enemy.id == i.id:
				enemy.LoadEnemy(i)

func LoadGame(name):
	LoadedGame = name
	var file = FileAccess.open("user://savedgames/" + name +"/" + name + ".dat", FileAccess.READ)
	var content = file.get_as_text()
	var obj = JSON.parse_string(content)
	#GameManager.loadedLevel = obj.gamemanager.scene
	#GameManager.spawnIndex = obj.gamemanager.spawnIndex
	#GameManager.Player.crouched = obj.player_crouched
	#GameManager.Inventory.LoadInventory(obj.inventory)
	PlayerCrouched = obj.player_crouched
	PlayerLocation = str_to_var(obj.player_location)
	PlayerRotation = str_to_var(obj.player_rotation)
	return obj

func LoadSceneData(name):
	var file = FileAccess.open("user://savedgames/" + LoadedGame +"/" + LoadedGame +  "_scene.dat", FileAccess.READ)
	var content = file.get_as_text()
	var obj = JSON.parse_string(content)
	return obj
