class_name ActionPawn extends CharacterBody2D

@onready var _boost_timer: Timer = %Boost_Timer
@onready var _center_overlap_area: Area2D = %Center_Overlap_Area2D

const _speed_boost_duration: float = 1.

const _SPEED_BOOSTED = 170.
const _SPEED = 50.0
var _speed = _SPEED

var _current_auto_direction: Manage_Ability_ProgramPath.PROGRAM_DIRECTIONS = \
	Manage_Ability_ProgramPath.PROGRAM_DIRECTIONS.UP

const _JUMP_VELOCITY = -400.0

var _who_controls_me: Battle_Maze_Container.WHO_CONTROLS = \
	Battle_Maze_Container.WHO_CONTROLS.NONE
	

const _APPROX_TARGET_DISTANCE: float = .1
var _is_wandering: bool = true
var _current_target: Vector2 = Vector2.ZERO
var _next_nav_pos: Vector2 = Vector2.ZERO


func _ready() -> void:
	_ready_who_controls()
	_ready_timers()
	_ready_connections()
	_ready_start_pos()
	print("action pawn ready")

func _ready_who_controls() -> void:
	var owner_node: Node = get_owner()
	if owner_node is Battle_Maze_Container:
		_who_controls_me = owner_node.get_who_controls_me()

func _ready_timers() -> void:
	_boost_timer.one_shot = true
		
func _ready_connections() -> void:
	if _who_controls_me == Battle_Maze_Container.WHO_CONTROLS.OPPONENT:
		return
	Manage_Abilities.ref.ability_chosen.connect(
		_on_ability_chosen)
		
	_boost_timer.timeout.connect(_on_boost_timeout)
	_center_overlap_area.area_entered.connect(
		_on_area_entered)
		
func _ready_start_pos() -> void:
	var start_pos: Vector2 = \
		Manage_PlayerActionPawn.ref.get_current_maze_entrance_pos()
		
	global_position = start_pos

@onready var _nav_agent: NavigationAgent2D = %NavigationAgent2D

func _boost_speed(indeed:bool) -> void:
	if indeed:
		_speed = _SPEED_BOOSTED
		_boost_timer.start(_speed_boost_duration)
	else:
		_speed = _SPEED

func change_auto_direction(
direction:Manage_Ability_ProgramPath.PROGRAM_DIRECTIONS
) -> void:
	_current_auto_direction = direction

func _physics_process(delta: float) -> void:
	if _who_controls_me == Battle_Maze_Container.WHO_CONTROLS.OPPONENT:
		return
		
	_physics_process_player_nav(delta)
	
	#if Manage_PlayerActionPawn.ref.is_state(
	#Manage_PlayerActionPawn.STATES.Brute_Force_Solver) \
	#or Manage_PlayerActionPawn.ref.is_state(
	#Manage_PlayerActionPawn.STATES.A_Star_Solver):
		#_physics_process_auto_nav(delta)
		##global_position = _nav_agent.target_position
		
		#_update_next_nav_pos()
	#elif not Manage_PlayerActionPawn.ref.is_state(
	#Manage_PlayerActionPawn.STATES.Brute_Force_Solver) \
	#or not Manage_PlayerActionPawn.ref.is_state(
	#Manage_PlayerActionPawn.STATES.A_Star_Solver):
		#_physics_process_player_nav(delta)
		
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
	Battle_Maze_Container.WHO_CONTROLS.PLAYER:
		#print("player pawn in control")
		if Manage_PlayerActionPawn.ref.is_state(
		Manage_PlayerActionPawn.STATES.Navigate):
			#print("manual navving")
			direction = Input.get_vector("Left", "Right", "Forward", "Backward").normalized()
		elif Manage_PlayerActionPawn.ref.is_state(
		Manage_PlayerActionPawn.STATES.Auto_Navigate):
			#print("autonavving")
			if _current_auto_direction == \
			Manage_Ability_ProgramPath.PROGRAM_DIRECTIONS.UP:
				direction = Vector2(0,-1)
			elif _current_auto_direction == \
			Manage_Ability_ProgramPath.PROGRAM_DIRECTIONS.DOWN:
				direction = Vector2(0,1)
			elif _current_auto_direction == \
			Manage_Ability_ProgramPath.PROGRAM_DIRECTIONS.LEFT:
				direction = Vector2(-1,0)
			elif _current_auto_direction == \
			Manage_Ability_ProgramPath.PROGRAM_DIRECTIONS.RIGHT:
				direction = Vector2(1,0)
		
		#print("PlayerActionPawn moving: ",direction)
	if direction:
		velocity.x = direction.x * _speed
		velocity.y = direction.y * _speed
	else:
		velocity.x = move_toward(velocity.x, 0, _speed)
		velocity.y = move_toward(velocity.y, 0, _speed)

	move_and_slide()
	
func _on_area_entered(area:Area2D) -> void:
	if not area.get_parent() is Programmed_Arrow:
		return
	
	var arrow: Programmed_Arrow = area.get_parent()
	
	if Manage_PlayerActionPawn.ref.is_state(
	Manage_PlayerActionPawn.STATES.Navigate):
		_boost_speed(true)
	elif Manage_PlayerActionPawn.ref.is_state(
	Manage_PlayerActionPawn.STATES.Auto_Navigate):
		change_auto_direction(
		arrow.get_my_direction())

func _on_ability_chosen(which: Manage_Abilities.ABILITIES) -> void:
	match which:
		Manage_Abilities.ABILITIES.Navigate:
			Manage_PlayerActionPawn.ref.change_state(
			Manage_PlayerActionPawn.STATES.Navigate)
		Manage_Abilities.ABILITIES.Auto_Navigate:
			Manage_PlayerActionPawn.ref.change_state(
			Manage_PlayerActionPawn.STATES.Auto_Navigate)
		#Manage_Abilities.ABILITIES.Brute_Force_Solver:
			#Manage_PlayerActionPawn.ref.change_state(
			#Manage_PlayerActionPawn.STATES.Brute_Force_Solver)
		#Manage_Abilities.ABILITIES.A_Star_Solver:
			#Manage_PlayerActionPawn.ref.change_state(
			#Manage_PlayerActionPawn.STATES.A_Star_Solver)

func _physics_process_auto_nav(_delta:float) -> void:
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

	var nav_finished: bool = _nav_agent.is_navigation_finished()
	var targ_reached: bool = _nav_agent.is_target_reached()

	if nav_finished and _is_wandering and not targ_reached:
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
			#var new_velocity: Vector2 = global_position.direction_to(position_to_follow) * _speed
			move_and_slide()
			
	# navigation is done but the cat isn't sitting yet
	else:
		move_and_slide()

func _on_boost_timeout() -> void:
	_boost_speed(false)
	
