extends Node3D

var E_childDoorOpenSlow : bool
var E_childRoomLaugh : bool



func _on_e_child_door_open_slow_body_entered(body):
	if !E_childDoorOpenSlow:
		get_node("%ChildRoomDoor").get_node("AnimationPlayer").play("DoorOpenSlow")
		E_childDoorOpenSlow = true
	pass # Replace with function body.
