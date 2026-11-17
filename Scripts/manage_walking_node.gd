class_name Manage_Walking extends Node
static var ref: Manage_Walking
func _init() -> void:
	ref = self
	
var _previous_state: STATES = STATES.NONE
var _state: STATES = STATES.NONE
enum STATES{
	NONE,
	OVERWORLD,
	UNDERWORLD,
	CUTSCENE
	}
	
func _ready() -> void:
	pass
	
func is_state(which:STATES) -> bool:
	return which == _state
	
func change_to_previous() -> void:
	change_state(_previous_state)

func change_state(to:STATES) -> bool:
	var change_approved: bool = false
	
	if _state == to:
		return false
		
	match to:
		STATES.NONE:
			change_approved = _check_none()
		STATES.OVERWORLD:
			change_approved = _check_overworld()
		STATES.UNDERWORLD:
			change_approved = _check_underworld()
		STATES.CUTSCENE:
			change_approved = _check_cutscene()
	
	if not to == STATES.NONE:
		change_approved = Manage_Game.ref.change_state(
							Manage_Game.STATES.WALKING)
	
	if change_approved:
		match to:
			STATES.NONE:
				_before_none()
			STATES.OVERWORLD:
				_before_overworld()
			STATES.UNDERWORLD:
				_before_underworld()
			STATES.CUTSCENE:
				_before_cutscene()
				
		_previous_state = _state
		_state = to
		
		match to:
			STATES.NONE:
				_after_none()
			STATES.OVERWORLD:
				_after_overworld()
			STATES.UNDERWORLD:
				_after_underworld()
			STATES.CUTSCENE:
				_after_cutscene()
		
		print("WALKING STATE: ",STATES.find_key(_state))
	else:
		print("REJECTED: WALKING STATE: ",STATES.find_key(_state))

	return change_approved	
		
func _check_none() -> bool:
	return true
func _before_none() -> void:
	pass
func _after_none() -> void:
	pass

func _check_overworld() -> bool:
	return true
func _before_overworld() -> void:
	await get_tree().process_frame
	Player.ref.lock_movement(false)
	Level_Container.ref.show_if_needed()
func _after_overworld() -> void:
	Manage_Overworld.ref.switch(
		Manage_Overworld.OVERWORLDS.OW1)
		
func _check_underworld() -> bool:
	return true
func _before_underworld() -> void:
	await get_tree().process_frame
	Player.ref.lock_movement(false)
	Level_Container.ref.show_if_needed()
func _after_underworld() -> void:
	Manage_Underworld.ref.switch(
		Manage_Underworld.UNDERWORLDS.OW1_UW1)
		
func _check_cutscene() -> bool:
	return true
func _before_cutscene() -> void:
	pass
func _after_cutscene() -> void:
	pass
