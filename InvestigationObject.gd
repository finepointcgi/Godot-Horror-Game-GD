extends Node3D

var isRotating := false
var mouseOffset : Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("LeftMouseDown"):
		isRotating = true
		mouseOffset = get_tree().root.get_mouse_position()
	elif Input.is_action_just_released("LeftMouseDown"):
		isRotating = false
	if isRotating:
		mouseOffset = get_tree().root.get_mouse_position() - mouseOffset
		$RotationAroundBase.rotation_degrees += Vector3(mouseOffset.y, mouseOffset.x, 0 ) * .4
		mouseOffset = get_tree().root.get_mouse_position()
	pass

func ShowObject(item : Item):
	show()
	if $RotationAroundBase.get_child_count() > 0:
		Utilities.removeChildren($RotationAroundBase)
	if item != null:
		if item.ResourcePath != null && item.ResourcePath != "":
			var instance = ResourceLoader.load(item.ResourcePath).instantiate()
			$RotationAroundBase.add_child(instance)
			instance.global_position = Vector3.ZERO
			instance.Spawn(item)
			instance.connect("FoundItem", FoundItem)

func HideObject():
	Utilities.removeChildren($RotationAroundBase)
	hide()

func FoundItem(item : Item, item2remove : Item, baseItem : Item):
	ShowObject(item)
	
	if baseItem != null:
		get_parent().Add(baseItem)
	get_parent().Add(item)
	if item2remove.DeleteItemAfterFound:
		get_parent().Remove(item2remove)
	#$RotationObjectBase/KinematicBody.hide()
	#$RotationObjectBase/InvestigationObject.global_position = Vector3(0,0,0)
