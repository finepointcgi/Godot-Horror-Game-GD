extends CharacterBody3D


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
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	NoiseValue = 0
	
	var space_state = get_world_3d().direct_space_state
	var surfaceResult = space_state.intersect_ray(PhysicsRayQueryParameters3D.create(global_position + Vector3(0,1,0), global_position + Vector3(0,-1,0), 1, [self]))
	var surface : Surface = GlobalAudioManager.SoundDict["Concrete"]
	
	if surfaceResult.size() > 0:
		if surfaceResult.has("collider"):
			var surfaceObject : Node3D = surfaceResult["collider"]
			if surfaceObject.has_meta("SurfaceType"):
				surface = GlobalAudioManager.SoundDict[surfaceObject.get_meta("SurfaceType")]
			
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	if is_on_floor():
		if wasInAir:
			$Jump.stream = surface.JumpLandSteamWAV
			$Jump.play()
			NoiseValue = surface.SoundLandValue
	# Handle Jump.
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
	LightLevel = get_node("Light Detect").LightLevel
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("MoveLeft", "MoveRight", "MoveForward", "MoveBackwards")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var speed = SPEED
	if Input.is_action_pressed("Crouch"):
		
		if !crouched:
			$AnimationPlayer.play("Crouch")
			crouched = true
	else:
		if crouched:
			var crouchedResult = space_state.intersect_ray(PhysicsRayQueryParameters3D.create(position, position + Vector3(0,2,0), 1, [self]))
			if crouchedResult.size() == 0:
				$AnimationPlayer.play("UnCrouch")
				crouched = false
	if crouched:
		speed = CROUCHSPEED
		
	if Input.is_action_just_pressed("Flashlight"):
		if flashLightIsOut:
			$AnimationPlayer.play("FlashlightHide")
		else:
			$AnimationPlayer.play("FlashlightShow")
		flashLightIsOut = !flashLightIsOut
		
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
		if !$Footsteps.is_playing() && is_on_floor():
			if crouched:
				$Footsteps.stream = surface.SneakSteamWAV
			else:
				$Footsteps.stream = surface.WalkSteamWAV
			$Footsteps.play()
		if NoiseValue < surface.SoundValue && !crouched:
					NoiseValue = surface.SoundValue
		if !is_on_floor():
			$Footsteps.stop()
	else:
		if $Footsteps.is_playing():
			$Footsteps.stop()
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	wasInAir = !is_on_floor()
	move_and_slide()
	
	
	

func _input(event):
	if(event is InputEventMouseMotion):
		rotation.y -= event.relative.x / 1000 * sensitivity
		$Camera3d.rotation.x -= event.relative.y / 1000 * sensitivity
		rotation.x = clamp(rotation.x, PI/-2, PI/2)
		$Camera3d.rotation.x = clamp($Camera3d.rotation.x, -2, 2)


func _on_sight_close_body_entered(body):
	pass # Replace with function body.
