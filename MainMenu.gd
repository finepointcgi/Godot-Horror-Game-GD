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
	pass # Replace with function body.


func _on_load_game_button_down():
	var obj = SaveLoadManager.LoadGame("checkpoint")
	GameManager.LoadLevel(obj.gamemanager.scene, obj.gamemanager.spawnIndex)
	GameManager.Inventory.LoadInventory(obj.inventory)
	queue_free()
	pass # Replace with function body.
