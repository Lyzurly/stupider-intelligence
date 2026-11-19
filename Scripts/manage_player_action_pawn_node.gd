class_name Manage_PlayerActionPawn extends Node
static var ref: Manage_PlayerActionPawn
func _init() -> void:
	ref = self

var _state: STATES = STATES.NONE
enum STATES{
	NONE,
	Navigate,
	Brute_Force_Solver,
	A_Star_Solver,
	}
	
func _ready() -> void:
	pass
	
func is_state(which:STATES) -> bool:
	return which == _state

func change_state(to:STATES) -> bool:
	var change_approved: bool = false
	
	if _state == to:
		return false
		
	match to:
		STATES.NONE:
			change_approved = _check_none()
		STATES.Navigate:
			change_approved = _check_navigate()
		STATES.Brute_Force_Solver:
			change_approved = _check_brute_force_solver()
		STATES.A_Star_Solver:
			change_approved = _check_a_star_solver()

	if change_approved:
		match to:
			STATES.NONE:
				_on_none()
			STATES.Navigate:
				_on_navigate()
			STATES.Brute_Force_Solver:
				_on_brute_force_solver()
			STATES.A_Star_Solver:
				_on_a_star_solver()
		_state = to
		print("ACTION PAWN STATE: ",STATES.find_key(_state))
	else:
		print("REJECTED: ACTION PAWN STATE: ",STATES.find_key(_state))

	return change_approved	
		
func _check_none() -> bool:
	return true
func _on_none() -> void:
	pass

func _check_navigate() -> bool:
	return true
func _on_navigate() -> void:
	pass
	
func _check_brute_force_solver() -> bool:
	return true
func _on_brute_force_solver() -> void:
	pass

func _check_a_star_solver() -> bool:
	return true
func _on_a_star_solver() -> void:
	pass

func _check_lost() -> bool:
	return true
func _on_lost() -> void:
	pass
