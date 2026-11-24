class_name Programmed_Arrow extends Node2D

const _DIR_SWITCH_SENSITIVTY: bool = 6.

@onready var _pawn_seeker_area: Area2D = %PawnSeeker_Area2D

var _is_placed: bool = false
var _my_direction: Manage_Ability_ProgramPath.PROGRAM_DIRECTIONS

func place_me() -> void:
	_is_placed = true
	
func get_my_direction() -> Manage_Ability_ProgramPath.PROGRAM_DIRECTIONS:
	return _my_direction
	
func _physics_process(_delta: float) -> void:
	_physics_process_placing()
	_physics_process_track_direction()
	
func _physics_process_placing() -> void:
	if _is_placed:
		return
		
	var mouse_pos: Vector2 = \
		get_global_mouse_position()
		
	global_position = mouse_pos 

func _physics_process_track_direction() -> void:
	if _is_placed:
		return
	var mouse_velocity: Vector2 = Input.get_last_mouse_velocity()
	
	if abs(mouse_velocity.x) < 6. \
	or abs(mouse_velocity.y) < 6.:
		return	
	
	if abs(mouse_velocity.x) > abs(mouse_velocity.y):
		if mouse_velocity.x > 0:
			_my_direction = \
				Manage_Ability_ProgramPath.PROGRAM_DIRECTIONS.RIGHT
			rotation = deg_to_rad(90.)
		elif mouse_velocity.x < 0:
			_my_direction = \
				Manage_Ability_ProgramPath.PROGRAM_DIRECTIONS.LEFT
			rotation = deg_to_rad(-90.)
	else:
		if mouse_velocity.y < 0:
			_my_direction = \
				Manage_Ability_ProgramPath.PROGRAM_DIRECTIONS.UP
			rotation = deg_to_rad(0.)
		elif mouse_velocity.y > 0:
			_my_direction = \
				Manage_Ability_ProgramPath.PROGRAM_DIRECTIONS.DOWN
			rotation = deg_to_rad(180.)
