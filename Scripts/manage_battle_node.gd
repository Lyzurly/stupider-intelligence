class_name Manage_Battle extends Node
static var ref: Manage_Battle
func _init() -> void:
	ref = self
	
var _state: STATES = STATES.NONE
enum STATES{
	NONE,
	INTRO,
	GAMEPLAY,
	WON,
	LOST,
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
		STATES.INTRO:
			change_approved = _check_intro()
		STATES.GAMEPLAY:
			change_approved = _check_gameplay()
		STATES.WON:
			change_approved = _check_won()
		STATES.LOST:
			change_approved = _check_lost()
	
	if change_approved:
		match to:
			STATES.NONE:
				_on_none()
			STATES.INTRO:
				_on_intro()
			STATES.GAMEPLAY:
				_on_gameplay()
			STATES.WON:
				_on_won()
			STATES.LOST:
				_on_lost()
		_state = to
		print("BATTLE STATE: ",STATES.find_key(_state))
	else:
		print("REJECTED: BATTLE STATE: ",STATES.find_key(_state))

	return change_approved	
		
func _check_none() -> bool:
	return true
func _on_none() -> void:
	pass

func _check_intro() -> bool:
	var approved = \
		Manage_Game.ref.change_state(
			Manage_Game.STATES.BATTLE)
	return approved
func _on_intro() -> void:
	Level_Container.ref.show_if_needed()
		
func _check_gameplay() -> bool:
	var approved = \
		Manage_Game.ref.change_state(
			Manage_Game.STATES.WALKING)
	return approved
func _on_gameplay() -> void:
	await get_tree().process_frame
	Level_Container.ref.show_if_needed()
		
func _check_won() -> bool:
	return true
func _on_won() -> void:
	pass

func _check_lost() -> bool:
	return true
func _on_lost() -> void:
	pass
