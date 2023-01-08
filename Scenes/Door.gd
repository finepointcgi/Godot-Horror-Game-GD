extends StaticBody3D

var doorOpen : bool
@export var HoverOverText : String
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func Interact():
	if doorOpen:
		$AnimationPlayer.play("Close")
	else:
		$AnimationPlayer.play("Open")
	doorOpen = !doorOpen

func GetInterfaceText():
	return HoverOverText
