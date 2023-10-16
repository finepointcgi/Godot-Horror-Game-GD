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
	var data : Dictionary = SaveLoadManager.LoadSceneData()
	var s = get_tree().get_nodes_in_group("Saveable")
	for i in get_tree().get_nodes_in_group("Saveable"):
		if i.name in data:
			i.Load(data[i.name])
	pass

func Save():
	return {
		"name": get_path(),
		"E_childDoorOpenSlow": var_to_str(E_childDoorOpenSlow),
		"E_childRoomLaugh" : var_to_str(E_childRoomLaugh)
	}
	
func Load(data):
	E_childDoorOpenSlow = str_to_var(data.E_childDoorOpenSlow)
	E_childRoomLaugh = str_to_var(data.E_childRoomLaugh)
