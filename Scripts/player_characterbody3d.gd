class_name Player extends CharacterBody3D
static var ref: Player
func _init() -> void:
	ref = self
	
@onready var _mesh_container: Node3D = %Player_MeshContainer

@onready var _mesh: MeshInstance3D = %Player_MeshInstance3D

@onready var _detect_area: Area3D = %Detect_Area3D

const SPEED = 12
const JUMP_VELOCITY = 4.5

var _movement_locked: bool = false

func _ready() -> void:
	_ready_connections()
	
func _ready_connections() -> void:
	_detect_area.area_entered.connect(
		_on_area_entered)

func lock_movement(indeed:bool) -> void:
	_movement_locked = indeed

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if _movement_locked:
		return
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir: Vector2 = Input.get_vector("Left", "Right", "Forward", "Backward")
	
	#print("\nVEL: ",velocity,"\nINP: ",input_dir,"\nVEL-L: ",velocity.length())
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	_mesh_container.global_rotation.y = transform.basis.get_euler().y
	
	if direction:
		
		var diagonal: bool = false
		var dir_to_face: float
		if direction.is_equal_approx(
		Vector3(0,0,-1)):
			dir_to_face = -90.
		elif direction.is_equal_approx(
		Vector3(0,0,1)):
			dir_to_face = 90.
		elif direction.is_equal_approx(
		Vector3(-1,0,0)):
			dir_to_face = 0.
		elif direction.is_equal_approx(
		Vector3(1,0,0)):
			dir_to_face = -180.
		elif direction.x < 0 \
		and direction.z < 0:
			diagonal = true
			dir_to_face = -45.
		elif direction.x > 0 \
		and direction.z > 0:
			diagonal = true
			dir_to_face = 135.
		elif direction.x > 0 \
		and direction.z < 0:
			diagonal = true
			dir_to_face = -135.
		elif direction.x < 0 \
		and direction.z > 0:
			diagonal = true
			dir_to_face = 45.
		
		var speed_scalar: float = \
			1.0 \
				if is_equal_approx(direction.z,0) \
				else \
			1.0 + abs(direction.z)/2
		
		if diagonal:
			speed_scalar = 1.0 + abs(direction.z)/4
		
		Camera.ref.lower_lerp_speed()
		velocity.x = direction.x * SPEED * speed_scalar
		velocity.z = direction.z * SPEED * speed_scalar
		
		#_mesh.global_rotation.y = \
			#lerp(
				#_mesh.global_rotation.y,
				#deg_to_rad(dir_to_face),
				#Camera.ref.get_low_lerp_speed())
		_mesh.global_rotation.y = \
			lerp(
				_mesh.global_rotation.y,
				deg_to_rad(dir_to_face),
				Camera.ref.get_default_lerp_speed())
		#print("\nVEL: ",velocity,"\nDIR: ",direction,"\nVEL-L: ",velocity.length(),"\n")
		#print("\n",direction,"\n",dir_to_face,"\n")
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	if velocity == Vector3.ZERO:
		Camera.ref.reset_lerp_speed()
	
	

	move_and_slide()

func _on_area_entered(area:Area3D) -> void:
	if area is OW_Underworld:
		print("WE HAVE ENTERED A TOWN")
		Manage_Underworld.ref.switch(
			Manage_Underworld.UNDERWORLDS.UNDERWORLD_1)
