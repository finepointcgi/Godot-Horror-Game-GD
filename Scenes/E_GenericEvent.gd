extends Area3D

@export var AudioToPlay : AudioStream
var audioPlayer : AudioStreamPlayer
@export var CanPlayMultipleTimes : bool
@export var VolumeToPlayAtInDB : float
var E_GenericEventPlayed : bool
# Called when the node enters the scene tree for the first time.
func _ready():
	audioPlayer = $AudioStreamPlayer
	audioPlayer.stream = AudioToPlay
	audioPlayer.volume_db = VolumeToPlayAtInDB
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if CanPlayMultipleTimes:
		audioPlayer.play()
	else:
		if !E_GenericEventPlayed:
			audioPlayer.play()
			E_GenericEventPlayed = true
	pass # Replace with function body.
