extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func LoadLevel(path):
	var loadScene : PackedScene = ResourceLoader.load("res://loading_screen.tscn")
	var loadSceneNode = loadScene.instantiate()
	get_tree().root.add_child(loadSceneNode)
	loadSceneNode.loadLevel(path)
	
