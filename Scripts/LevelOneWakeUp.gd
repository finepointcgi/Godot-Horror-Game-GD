extends Node3D

var E_childDoorOpenSlow : bool
var E_childRoomLaugh : bool

func _ready():
	if GameManager.LoadingFromSave:
		loadLevelData()

func _on_e_child_door_open_slow_body_entered(body):
	if !E_childDoorOpenSlow:
		get_node("%ChildRoomDoor").get_node("AnimationPlayer").play("DoorOpenSlow")
		E_childDoorOpenSlow = true
		get_node("%ChildRoomDoor").doorOpen = true
	pass # Replace with function body.


func loadLevelData():
	var data : Dictionary  = SaveLoadManager.LoadSceneData("checkpoint")
	for i in get_tree().get_nodes_in_group("Saveable"):
		#print(data.sceneObjects[i.get_path()])
		if i.name in data.sceneObjects:
			i.Load(data.sceneObjects[i.name])
	
