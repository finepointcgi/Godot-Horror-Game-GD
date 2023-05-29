extends StaticBody3D

@export var LevelPath : String
@export var InstanceIndex : int
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func Interact():
	GameManager.LoadLevel(LevelPath, InstanceIndex)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
