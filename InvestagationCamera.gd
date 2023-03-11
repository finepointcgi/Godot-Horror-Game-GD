extends Camera3D

var zoomSpeed = .2
var zoomDirection = Vector3(0,0,-1)

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_UP:
		translate((zoomDirection * zoomSpeed))
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		translate(zoomDirection * -zoomSpeed)
