extends Control

var loading : bool
var path : String
var waitForInput : bool
var inputKeyPressed : bool
var spawnIndex : int
@export var  tips : Array[String]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if loading:
		var progress = []
		var status = ResourceLoader.load_threaded_get_status(path, progress)
		if status == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			print(progress[0] * 100)
			$ProgressBar.value = progress[0] * 100
		elif status == ResourceLoader.THREAD_LOAD_LOADED:
			set_process(false)
			print("Level Loaded")
			$ProgressBar.value = 100
			waitForInput = true
	pass

func _input(event):
	if waitForInput:
		if event is InputEventKey:
			if inputKeyPressed:
				GameManager.UnpauseGame()
				ChangeScene(ResourceLoader.load_threaded_get(path))
			
			if !event.pressed:
				inputKeyPressed = false
			else:
				inputKeyPressed = true

func ChangeScene(resource : PackedScene):
	var currentNode = resource.instantiate()
	
	GameManager.CheckForPlayer()
	GameManager.LevelBase.add_child(currentNode)
	
	for item in GameManager.LevelBase.get_children():
		if item != currentNode:
			GameManager.LevelBase.remove_child(item)
			item.queue_free()
	
	if !GameManager.LoadingFromSave:
		GameManager.MovePlayer(spawnIndex)
	queue_free()
	
func LoadLevel(path : String, spawnIndex : int):
	self.path = path
	self.spawnIndex = spawnIndex
	show()
	if tips.size() != 0:
		$Control/VBoxContainer2/TipValue.text = tips[randi() % tips.size()]
	var items : PackedStringArray = path.split("/")
	var levelname = items[items.size() - 1].split(".")
	$Control/VBoxContainer/LevelName.text = levelname[0]
	if(ResourceLoader.has_cached(path)):
		ResourceLoader.load_threaded_get(path)
	else:
		ResourceLoader.load_threaded_request(path, "", true)
		loading = true
