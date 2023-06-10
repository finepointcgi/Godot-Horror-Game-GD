extends StaticBody3D

@export var LevelPath : String
@export var TargetSpawnIndex : int
@export var LocalIndex : int
# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnIndex.SpawnIndex = LocalIndex
	pass # Replace with function body.

func Interact():
	GameManager.LoadLevel(LevelPath, TargetSpawnIndex)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
