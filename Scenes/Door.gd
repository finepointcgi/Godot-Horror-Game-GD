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

func Save():
	return {
		"name": get_path(),
		"position": var_to_str(global_position),
		"rotation" : var_to_str(rotation_degrees),
		"doorOpen" : var_to_str(doorOpen)
	}
	
func Load(data):
	global_position = str_to_var(data.position)
	rotation_degrees = str_to_var(data.rotation)
	doorOpen = str_to_var(data.doorOpen)
