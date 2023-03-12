extends CharacterBody3D
var item : Item
var overKey : bool
signal FoundItem(item)
func _ready():
	if item.SubItem != null:
		var item = ResourceLoader.load(item.SubItem.ResourcePath).instantiate()
		$SubObject.add_child(item)
		item.connect("mouse_entered", objectAreaEntered)
		item.connect("mouse_exited", objectAreaExited)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if overKey:
		if Input.is_action_just_pressed("LeftMouseDown"):
			Interact()
	pass
	

func objectAreaEntered():
	print("entered")
	overKey = true
	pass
	
func objectAreaExited():
	print("exited")
	overKey = false
	pass
	
func Interact():
	emit_signal("FoundItem", item.SubItemPath, item)
	pass
