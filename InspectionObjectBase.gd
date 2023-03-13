extends CharacterBody3D
var item : Item
var overKey : bool
signal FoundItem(item)
func _ready():
	pass # Replace with function body.

func Spawn(currentItem):
	self.item = currentItem
	if item.SubItem != null && !item.SubItemFound:
		var spawnedItem = ResourceLoader.load(currentItem.SubItem.ResourcePath).instantiate()
		$SubObject.add_child(spawnedItem)
		spawnedItem.get_node("Area3D").connect("mouse_entered", objectAreaEntered)
		spawnedItem.get_node("Area3D").connect("mouse_exited", objectAreaExited)

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
	print("interacting")
	item.SubItemFound = true
	emit_signal("FoundItem", item.SubItem, item, item.AfterFoundBaseItem)
	pass
