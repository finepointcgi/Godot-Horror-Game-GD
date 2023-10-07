extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func SaveGame(obj, name):
	var save_data = {
		"gamemanager":{
			"scene" : GameManager.loadedLevel,
			"spawnIndex" : GameManager.spawnIndex
		},
		"player_crouched": GameManager.Player.crouched,
		"inventory": GameManager.Inventory.SaveInventory()
	}
	var save_json = JSON.stringify(save_data)
	var file = FileAccess.open("user://" + name +  ".dat", FileAccess.WRITE)
	file.store_string(save_json)

func LoadGame(name):
	var file = FileAccess.open("user://" + name +  ".dat", FileAccess.READ)
	var content = file.get_as_text()
	var obj = JSON.parse_string(content)
	#GameManager.loadedLevel = obj.gamemanager.scene
	#GameManager.spawnIndex = obj.gamemanager.spawnIndex
	#GameManager.Player.crouched = obj.player_crouched
	#GameManager.Inventory.LoadInventory(obj.inventory)
	return obj
