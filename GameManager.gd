extends Node

var Player : Node3D
var PlayerScenePath : String = "res://Scenes/Character.tscn"
var LevelBase : Node
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func LoadLevel(path : String, targetIndex : int):
	var loadScene : PackedScene = ResourceLoader.load("res://loading_screen.tscn")
	var loadSceneNode = loadScene.instantiate()
	get_tree().get_nodes_in_group("LevelBase")[0].add_child(loadSceneNode)
	loadSceneNode.loadLevel(path, targetIndex)
	
	if(Player == null):
		var playerScene : PackedScene = ResourceLoader.load(PlayerScenePath)
		Player = playerScene.instantiate()
		get_tree().get_nodes_in_group("PlayerParent")[0].add_child(Player)
	
	
func MovePlayer(targetIndex : int):
	var indexs : Array[Node] = get_tree().get_nodes_in_group("SpawnIndex")
		
	for i in indexs:
		if i.SpawnIndex == targetIndex:
			Player.global_position = i.global_position
