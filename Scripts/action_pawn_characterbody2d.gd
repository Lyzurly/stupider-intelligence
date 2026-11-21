class_name ActionPawn extends CharacterBody2D

const SPEED = 50.0
const JUMP_VELOCITY = -400.0

var _who_controls_me: Battle_Maze_Container.WHO_CONTROLS = \
	Battle_Maze_Container.WHO_CONTROLS.NONE

func _ready() -> void:
	_ready_who_controls()
	_ready_connections()
	_ready_start_pos()
	print("action pawn ready")

func _ready_who_controls() -> void:
	var owner_node: Node = get_owner()
	if owner_node is Battle_Maze_Container:
		_who_controls_me = owner_node.get_who_controls_me()
		
func _ready_connections() -> void:
	if _who_controls_me == Battle_Maze_Container.WHO_CONTROLS.OPPONENT:
		return
	Manage_Abilities.ref.ability_chosen.connect(
		_on_ability_chosen)
		
func _ready_start_pos() -> void:
	var start_pos: Vector2 = \
		Manage_PlayerActionPawn.ref.get_current_maze_entrance_pos()
		
	global_position = start_pos

@onready var _nav_agent: NavigationAgent2D = %NavigationAgent2D

func _physics_process(delta: float) -> void:
	if _who_controls_me == Battle_Maze_Container.WHO_CONTROLS.OPPONENT:
		return
	
	if Manage_PlayerActionPawn.ref.is_state(
	Manage_PlayerActionPawn.STATES.Brute_Force_Solver) \
	or Manage_PlayerActionPawn.ref.is_state(
	Manage_PlayerActionPawn.STATES.A_Star_Solver):
		_physics_process_auto_nav(delta)
		#global_position = _nav_agent.target_position
		
		_update_next_nav_pos()
	elif not Manage_PlayerActionPawn.ref.is_state(
	Manage_PlayerActionPawn.STATES.Brute_Force_Solver) \
	or not Manage_PlayerActionPawn.ref.is_state(
	Manage_PlayerActionPawn.STATES.A_Star_Solver):
		_physics_process_player_nav(delta)
		

func _physics_process_player_nav(delta: float) -> void:
	_nav_agent.target_position = global_position
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var direction: Vector2
	
	if _who_controls_me == \
	Battle_Maze_Container.WHO_CONTROLS.OPPONENT:
		pass
	elif _who_controls_me == \
	Battle_Maze_Container.WHO_CONTROLS.PLAYER \
	and Manage_PlayerActionPawn.ref.is_state(
	Manage_PlayerActionPawn.STATES.Navigate):
		direction = Input.get_vector("Left", "Right", "Forward", "Backward").normalized()
		
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

func _on_ability_chosen(which: Manage_Abilities.ABILITIES) -> void:
	match which:
		Manage_Abilities.ABILITIES.Navigate:
			Manage_PlayerActionPawn.ref.change_state(
			Manage_PlayerActionPawn.STATES.Navigate)
		Manage_Abilities.ABILITIES.Brute_Force_Solver:
			Manage_PlayerActionPawn.ref.change_state(
			Manage_PlayerActionPawn.STATES.Brute_Force_Solver)
		Manage_Abilities.ABILITIES.A_Star_Solver:
			Manage_PlayerActionPawn.ref.change_state(
			Manage_PlayerActionPawn.STATES.A_Star_Solver)

var _speed: float = SPEED
const _APPROX_TARGET_DISTANCE: float = .1
var _is_wandering: bool = true
var _current_target: Vector2 = Vector2.ZERO
var _next_nav_pos: Vector2 = Vector2.ZERO

func _physics_process_auto_nav(delta:float) -> void:
	_follow_next_point()
	
# Functions responsible for calculating waypoints, setting the Navigation Agent target, and following the path.
#-------------------------------------------------------------------------------
#region Core Navigation Logic 
func _update_next_nav_pos() -> void:
	var next_waypoint: Vector2 = _get_next_waypoint()
	if next_waypoint == Vector2.ZERO:
		push_warning(
		"Can't update next waypoint, it is invalid!")
		return
		
	_current_target = _get_next_waypoint()
	if _next_nav_pos == _current_target:
		#print.fancy("New waypoint abandoned!")
		pass
	else:
		_next_nav_pos = _current_target
		_nav_agent.target_position = _next_nav_pos

func _get_next_waypoint() -> Vector2:
	var next_waypoint: Vector2
	#print.fancy("Getting next waypoint...")

	var rand_roll_position: Vector2 = Vector2(
		randf_range(-.75, .75),    
		randf_range(-7., -2.6)    
	)
	next_waypoint = rand_roll_position
	
	#print.fancy("Next waypoint chosen:",next_waypoint,"!")
	return next_waypoint
	
func _on_journey_begin() -> void:
	move_and_slide()
	_update_next_nav_pos()
	
func _follow_next_point() -> void:
	var position_to_follow: Vector2 = Vector2.ZERO # Initialize to avoid uninitialized read
	if NavigationServer2D.map_get_iteration_id(_nav_agent.get_navigation_map()) == 0:
		#print.fancy("No nav map found!")
		_update_next_nav_pos()
		return

	if _nav_agent.is_navigation_finished() and _is_wandering and not _nav_agent.is_target_reached():
		_on_journey_begin()
		_is_wandering = false

	# Use _nav_agent.get_next_path_position() for movement and rotation
	var next_path_position: Vector2 = _nav_agent.get_next_path_position()
	var final_path_position: Vector2 = _nav_agent.get_final_position()
	
	# Condition 1: Reached the final target (use final_path_position for distance)
	var distance_to_final_path_pos: float = global_position.distance_to(final_path_position)
	if distance_to_final_path_pos < _APPROX_TARGET_DISTANCE:
		#_on_journey_begin() 
		
		print("ACTION PAWN AUTO MOVE STOPPED at ", _nav_agent.target_position)
		# Collapse agent path to current position to prevent residual nudges
		_nav_agent.target_position = global_position
		
		move_and_slide()
		_is_wandering = false
		return # Return immediately to stop movement calculations
	
	# Condition 2: Continue walking towards the next point
	if not next_path_position.is_equal_approx(global_position):
		position_to_follow = next_path_position

	# Condition 3: Apply movement based on position_to_follow
	# Ensure movement is only calculated if a valid position_to_follow was set (i.e., we are still navigating)
	if not position_to_follow == Vector2.ZERO:
		var distance_to_next_path_pos: float = global_position.distance_to(position_to_follow)
		
		#Safety net that ensures cat doesn't accidentally try to move toward a point that’s effectively “reached.”
		if distance_to_next_path_pos > _APPROX_TARGET_DISTANCE:
			var new_velocity: Vector2 = global_position.direction_to(position_to_follow) * _speed
			move_and_slide()
			
	# navigation is done but the cat isn't sitting yet
	else:
		move_and_slide()
