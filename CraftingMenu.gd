extends Control

@export var CraftableItems : Array
@export var CraftableButton : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	for item in CraftableItems:
		add(item)
	pass # Replace with function body.

func add(item : Item):
	var currentCraftButton = CraftableButton.instantiate()
	currentCraftButton.UpdateItem(item, 0, InventoryButton.InventoryButtonStates.Craftable)
	currentCraftButton.connect("OnButtonClick", OnCraftButtonClicked)
	$GridContainer.add_child(currentCraftButton)


func OnCraftButtonClicked(index, item, state):
	item.CraftItem()


func _on_button_button_down():
	queue_free()
	pass # Replace with function body.
