extends RigidBody3D

@export var HoverOverText : String
@export var GrabbableObjectResource : Resource
var NoiseValue = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", BodyEntered)
	pass # Replace with function body.

func BodyEntered(body):
	if GrabbableObjectResource.HitSoundWAV != null:
		$AudioStreamPlayer3D.stream = GrabbableObjectResource.HitSoundWAV
		$AudioStreamPlayer3D.play()
		NoiseValue = GrabbableObjectResource.NoiseLevel
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if NoiseValue > 0:
		await get_tree().create_timer(.2).timeout
		NoiseValue = 0
	pass
	
func Interact():
	get_tree().get_nodes_in_group("Player")[0].GrabObject(self)
	pass

func GetInterfaceText():
	return HoverOverText

func Save():
	return {
		"name": get_path(),
		"position": var_to_str(global_position),
		"rotation" : var_to_str(rotation_degrees)
	}
	
func Load(data):
	global_position = str_to_var(data.position)
	rotation_degrees = str_to_var(data.rotation)
