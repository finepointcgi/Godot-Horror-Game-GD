extends CharacterBody3D

enum states{
	walking,
	sneaking,
	crouching,
	inAir,
	standing,
	jumping
}

const SPEED = 5.0
const CROUCHSPEED = 2.0
const JUMP_VELOCITY = 4.5
@export var sensitivity = 3
var crouched : bool
var flashLightIsOut : bool
var LightLevel : float
var wasInAir : bool
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var NoiseValue = 0
@onready var footAudioPlayer := $Footsteps
@onready var jumpAudioPlayer := $Jump

var initSurfaceObject : SurfaceObject

var currentState := states.standing

var grabbedObject : RigidBody3D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	initSurfaceObject = SurfaceObject.new()
	initSurfaceObject.SurfaceResource = ResourceLoader.load("res://Sounds/Wood.tres")

func _physics_process(delta):
	if GameManager.Paused:
		return
		
	wasInAir = !is_on_floor()
	var velocity = getInput()
	LightLevel = get_node("Light Detect").LightLevel
	
	handleSound(getSurface())
	handleAnimation()
	handleMovement(velocity, delta)


func handleAnimation():
	var space_state = get_world_3d().direct_space_state
	if currentState == states.crouching || currentState == states.sneaking:
		if !crouched:
			$AnimationPlayer.play("Crouch")
			crouched = true
	else:
		if crouched:
			var crouchedResult = space_state.intersect_ray(
				PhysicsRayQueryParameters3D.create(position, 
				position + Vector3(0,2,0), 
				1, 
				[self.get_rid()]))
				
			if crouchedResult.size() == 0:
				$AnimationPlayer.play_backwards("Crouch")
				crouched = false
			else:
				currentState = states.sneaking

func handleSound(surface : SurfaceObject):
	NoiseValue = 0
	if currentState == states.walking :
		NoiseValue = surface.SurfaceResource.SoundValue
		if !footAudioPlayer.playing:
			footAudioPlayer.stream = surface.SurfaceResource.WalkSteamWAV
			footAudioPlayer.play()
		
		
	if currentState == states.sneaking :
		NoiseValue = surface.SurfaceResource.SoundValue / 3
		if !footAudioPlayer.playing:
			footAudioPlayer.stream = surface.SurfaceResource.SneakSteamWAV
			footAudioPlayer.play()
		
	
	if currentState == states.inAir && wasInAir:
		jumpAudioPlayer.stream = surface.SurfaceResource.JumpLandSteamWAV
		jumpAudioPlayer.play()
		NoiseValue = surface.SurfaceResource.SoundLandValue
	
	if currentState == states.standing || currentState == states.crouching:
		if footAudioPlayer.playing:
			footAudioPlayer.stop()
	pass

func handleMovement(direction : Vector3, delta : float):
	var speed = SPEED
	if currentState == states.sneaking:
		speed = CROUCHSPEED
	
	if currentState == states.jumping:
		velocity.y = JUMP_VELOCITY
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
		# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	move_and_slide()

func getInput() -> Vector3:
	var input_dir = Input.get_vector("MoveLeft", "MoveRight", "MoveForward", "MoveBackwards")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if Input.is_action_just_pressed("Flashlight"):
		handleFlashLight()
	
	if direction != Vector3.ZERO:
		if(Input.is_action_pressed("Crouch")):
			currentState = states.sneaking
		else:
			currentState = states.walking
	else:
		if(Input.is_action_pressed("Crouch")):
			currentState = states.crouching
		else:
			currentState = states.standing
	
	if(Input.is_action_just_pressed("Jump")) && is_on_floor():
		currentState = states.jumping
	
	if Input.is_action_just_pressed("Inventory"):
		GameManager.Inventory.visible = !GameManager.Inventory.visible
		if GameManager.Inventory.visible:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
	if(!is_on_floor()):
		currentState = states.inAir
		
	if ($Camera3d/RayCast3D.is_colliding()):
		var obj = $Camera3d/RayCast3D.get_collider()
		if(Input.is_action_just_pressed("Interact")):
			obj.Interact()
	
	if Input.is_action_just_pressed("Throw"):
		if grabbedObject != null:
			var temp = grabbedObject
			GrabObject(grabbedObject)
			temp.apply_impulse(($Camera3d.global_position - temp.global_position).normalized() * -1 * 5)
	
	if Input.is_action_just_pressed("Pause"):
		if GameManager.Paused:
			GameManager.UnpauseGame()
		else:
			GameManager.PauseGame()
	
	return direction
	
func handleFlashLight():
	if flashLightIsOut:
		$AnimationPlayer.play("FlashlightHide")
	else:
		$AnimationPlayer.play("FlashlightShow")
	flashLightIsOut = !flashLightIsOut

func getSurface() -> SurfaceObject:
	var space_state = get_world_3d().direct_space_state
	var surfaceResult = space_state.intersect_ray(PhysicsRayQueryParameters3D.create(global_position + Vector3(0,1,0), global_position + Vector3(0,-1,0), 1, [self.get_rid()]))
	var surface : SurfaceObject = initSurfaceObject
	
	if surfaceResult.size() > 0:
		if surfaceResult.has("collider"):
			if surfaceResult["collider"] is SurfaceObject:
				surface = surfaceResult["collider"]
	return surface

func _input(event):
	if GameManager.Paused:
		return
	if(event is InputEventMouseMotion) && !GameManager.Inventory.visible:
		rotation.y -= event.relative.x / 1000 * sensitivity
		$Camera3d.rotation.x -= event.relative.y / 1000 * sensitivity
		rotation.x = clamp(rotation.x, PI/-2, PI/2)
		$Camera3d.rotation.x = clamp($Camera3d.rotation.x, -2, 2)

func GrabObject(obj : RigidBody3D):
	if grabbedObject == null:
		grabbedObject = obj
		$Camera3d/Generic6DOFJoint3D.node_b = obj.get_path()
	else:
		grabbedObject = null
		$Camera3d/Generic6DOFJoint3D.node_b = $Camera3d/Generic6DOFJoint3D/ResetObject.get_path()
		

func Save():
	var data = {
		"position" : var_to_str(global_position),
		"rotation" : var_to_str( rotation_degrees),
		"name" : get_path()
	}
	
	return data
	
func Load(data):
	global_position = str_to_var(data.position)
	rotation_degrees = str_to_var(data.rotation)
	pass
