extends Node

@export var PauseMenu : PackedScene
var currentPauseMenu : Node

@export var LoadMenu : PackedScene
var currentLoadMenu : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.UIManager = self
	pass # Replace with function body.

func HideUI():
	for i in get_children():
		i.hide()
		
func ShowUI():
	for i in get_children():
		i.show()
		
		
func Pause():
	if !GameManager.paused:
		currentPauseMenu = PauseMenu.instantiate()
		add_child(currentPauseMenu)
	else:
		currentPauseMenu.queue_free()

func ShowLoadMenu():
	currentLoadMenu = LoadMenu.instantiate()
	add_child(currentLoadMenu)

func RemoveLoadMenu():
	currentLoadMenu.queue_free() 
