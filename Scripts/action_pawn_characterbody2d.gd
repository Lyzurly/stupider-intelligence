class_name ActionPawn extends CharacterBody2D

const SPEED = 50.0
const JUMP_VELOCITY = -400.0

var _who_controls_me: Battle_Maze_Container.WHO_CONTROLS = \
	Battle_Maze_Container.WHO_CONTROLS.NONE

func _ready() -> void:
	_ready_who_controls()

func _ready_who_controls() -> void:
	var owner_node: Node = get_owner()
	if owner_node is Battle_Maze_Container:
		_who_controls_me = owner_node.get_who_controls_me()
		
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var direction: Vector2
	
	if _who_controls_me == \
	Battle_Maze_Container.WHO_CONTROLS.OPPONENT:
		pass
	elif _who_controls_me == \
	Battle_Maze_Container.WHO_CONTROLS.PLAYER:
		direction = Input.get_vector("Left", "Right", "Forward", "Backward").normalized()
		
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
