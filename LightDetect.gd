extends Node3D

var LightLevel : float
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var meshInstance := get_node("MeshInstance3D")
	get_node("SubViewportContainer/SubViewport/Camera3D").global_position = Vector3(meshInstance.global_position.x,meshInstance.global_position.y + .3, meshInstance.global_position.z)
	
	var image : Image = get_node("SubViewportContainer/SubViewport").get_texture().get_image()
	var floats : Array[float]
	for y in range(0, image.get_height()):
		for x in range(0, image.get_width()):
			var pixel = image.get_pixel(x,y)
			var lightValue = (pixel.r + pixel.g + pixel.b) / 3
			floats.append(lightValue)
	LightLevel = average(floats)
	pass
	
func average(numbers: Array) -> float:
	var sum = 0.0
	for n in numbers:
		sum += n
	return sum / numbers.size()
