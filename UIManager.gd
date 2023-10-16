extends Node

@export var PauseMenu : PackedScene
var currentPauseMenu : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.UIManager = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func HideUI():
	for i in get_children():
		i.hide()

func ShowUI():
	for i in get_children():
		i.show()

func Pause(paused):
	if paused:
		currentPauseMenu = PauseMenu.instantiate()
		add_child(currentPauseMenu)
	else:
		if currentPauseMenu != null:
			currentPauseMenu.queue_free()
