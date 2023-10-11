extends Node

var LevelBase : Node
var Player : Node3D
var playerScenePath : String = "res://Scenes/Character.tscn"
var Inventory : Inventory
var UIManager
var loadedLevel : String 
var spawnIndex : int
var LoadingFromSave : bool
var LoadingPath : String
var paused : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func LoadLevel(path : String, spawnIndex : int):
	loadedLevel = path
	self.spawnIndex = spawnIndex
	var loadScene : PackedScene = ResourceLoader.load("res://loading_screen.tscn")
	var loadSceneNode = loadScene.instantiate()
	get_tree().root.add_child(loadSceneNode)
	loadSceneNode.LoadLevel(path, spawnIndex)

	if(Player != null):
		Player.ReadyPlayer()
	
func CheckForPlayer():
	if(Player == null):
		var playerScene : PackedScene = ResourceLoader.load(playerScenePath)
		Player = playerScene.instantiate()
		get_tree().get_nodes_in_group("PlayerParent")[0].add_child(Player)

func MovePlayer(targetIndex : int, position, rotationDegrees):
	var indexs : Array[Node] = get_tree().get_nodes_in_group("SpawnIndex")
	if position == Vector3(0, 0, 0) && rotationDegrees == Vector3(0, 0, 0):
		for i in indexs:
			if i.SpawnIndex == targetIndex:
				Player.global_position = i.global_position
				Player.rotation_degrees = i.rotation_degrees
	else:
		Player.global_position = position
		Player.rotation_degrees = rotationDegrees


func EndGame():
	LoadLevel(loadedLevel, spawnIndex)

func Pause():
	if !paused:
		UIManager.Pause()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		
	else:
		UIManager.Pause()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
	#get_tree().paused = paused
	paused = !paused
	
