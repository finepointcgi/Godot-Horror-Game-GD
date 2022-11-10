extends Node
class_name AudioManager

var SoundDict : Dictionary
# Called when the node enters the scene tree for the first time.
func _ready():
	
	var s : Surface = Surface.new()
	s.WalkSteamWAV = ResourceLoader.load("res://Sounds/FootstepsOnWood.wav")
	s.SneakSteamWAV = ResourceLoader.load("res://Sounds/FootstepsOnWood.wav")
	s.JumpLandSteamWAV = ResourceLoader.load("res://Sounds/JumpLand.wav")
	s.SoundValue = 5
	s.SoundLandValue = 10
	
	SoundDict["Wood"] = s
	
	var concrete : Surface = Surface.new()
	concrete.WalkSteamWAV = ResourceLoader.load("res://Sounds/FootstepsOnConcrete.wav")
	concrete.SneakSteamWAV = ResourceLoader.load("res://Sounds/FootstepsOnConcrete.wav")
	concrete.JumpLandSteamWAV = ResourceLoader.load("res://Sounds/JumpLand.wav")
	concrete.SoundValue = 6
	concrete.SoundLandValue = 12
	
	SoundDict["Concrete"] = concrete
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
