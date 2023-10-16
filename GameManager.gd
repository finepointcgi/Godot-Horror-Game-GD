extends Node

var LevelBase : Node
var Player : Node3D
var playerScenePath : String = "res://Scenes/Character.tscn"
var Inventory : Inventory
var UIManager : Node

var LoadedLevel : String
var SpawnIndex : int

var Paused : bool
var LoadingFromSave : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func LoadLevel(path : String, spawnIndex : int):
	
	LoadedLevel = path
	SpawnIndex = spawnIndex
	
	var loadScene : PackedScene = ResourceLoader.load("res://loading_screen.tscn")
	var loadSceneNode = loadScene.instantiate()
	get_tree().root.add_child(loadSceneNode)
	loadSceneNode.LoadLevel(path, spawnIndex)
	
func CheckForPlayer():
	if(Player == null):
		var playerScene : PackedScene = ResourceLoader.load(playerScenePath)
		Player = playerScene.instantiate()
		get_tree().get_nodes_in_group("PlayerParent")[0].add_child(Player)

func MovePlayer(targetIndex : int):
	var indexs : Array[Node] = get_tree().get_nodes_in_group("SpawnIndex")
	
	for i in indexs:
		if i.SpawnIndex == targetIndex:
			Player.global_position = i.global_position
			Player.rotation_degrees = i.rotation_degrees

func PauseGame():
	UIManager.Pause(true)
	Paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func UnpauseGame():
	UIManager.Pause(false)
	Paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
