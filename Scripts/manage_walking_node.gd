class_name Manage_Walking extends Node
static var ref: Manage_Walking
func _init() -> void:
	ref = self
	
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
	
	if change_approved:
		match to:
			STATES.NONE:
				_on_none()
			STATES.OVERWORLD:
				_on_overworld()
			STATES.UNDERWORLD:
				_on_underworld()
			STATES.CUTSCENE:
				_on_cutscene()
		_state = to
		print("WALKING STATE: ",STATES.find_key(_state))
	else:
		print("REJECTED: WALKING STATE: ",STATES.find_key(_state))

	return change_approved	
		
func _check_none() -> bool:
	return true
func _on_none() -> void:
	pass

func _check_overworld() -> bool:
	var approved = \
		Manage_Game.ref.change_state(
			Manage_Game.STATES.WALKING)
	return approved
func _on_overworld() -> void:
	await get_tree().process_frame
	Player.ref.lock_movement(false)
	Level_Container.ref.show_if_needed()
		
func _check_underworld() -> bool:
	var approved = \
		Manage_Game.ref.change_state(
			Manage_Game.STATES.WALKING)
	return approved
func _on_underworld() -> void:
	await get_tree().process_frame
	Player.ref.lock_movement(false)
	Level_Container.ref.show_if_needed()
		
func _check_cutscene() -> bool:
	return true
func _on_cutscene() -> void:
	pass
