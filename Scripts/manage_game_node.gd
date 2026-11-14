class_name Manage_Game extends Node
static var ref: Manage_Game
func _init() -> void:
	ref = self

var _previous_state: STATES = STATES.NONE
var _state: STATES = STATES.NONE
enum STATES{
	NONE,
	MENUS, ## Create Character, Shops, Pause,
	CINEMATIC,
	WALKING, ## Overworld, Location, Cutscene
	BATTLE, ## Intro, Gameplay, Win, Lost
	}
	
func _ready() -> void:
	Manage_Menus.ref.change_state(
		Manage_Menus.STATES.MAIN)

func is_state(which:STATES) -> bool:
	return which == _state
func is_previous_state(which:STATES) -> bool:
	return which == _previous_state

func change_state(to:STATES) -> bool:
	var change_approved: bool = false
	
	#NOTE If you comment this in, changing the walking state will get rejected!
	#if _state == to:
		#return change_approved
			
	match to:
		STATES.NONE:
			change_approved = _check_none()
		STATES.MENUS:
			change_approved = _check_menus()
		STATES.CINEMATIC:
			change_approved = _check_cinematic()
		STATES.WALKING:
			change_approved = _check_walking()
		STATES.BATTLE:
			change_approved = _check_battle()

	
	if change_approved:
		match to:
			STATES.NONE:
				_on_none()
			STATES.MENUS:
				_on_menus()
			STATES.CINEMATIC:
				_on_cinematic()
			STATES.WALKING:
				_on_walking()
			STATES.BATTLE:
				_on_battle()
		_previous_state = _state
		_state = to
		
		match _previous_state:
			STATES.NONE:
				_on_previously_none()
			STATES.MENUS:
				_on_previously_menus()
			STATES.CINEMATIC:
				_on_previously_cinematic()
			STATES.WALKING:
				_on_previously_walking()
			STATES.BATTLE:
				_on_previously_battle()
		
		print("GAME STATE: ",STATES.find_key(_state))
	else:
		print("REJECTED: GAME STATE: ",STATES.find_key(_state))
		
	return change_approved
		
func _check_none() -> bool:
	return true
func _on_none() -> void:
	pass
func _on_previously_none() -> void:
	pass

func _check_menus() -> bool:
	return true
func _on_menus() -> void:
	pass
func _on_previously_menus() -> void:
	Manage_Menus.ref.change_state(
		Manage_Menus.STATES.NONE)
	
func _check_cinematic() -> bool:
	#TODO BLOCK IF COMING FROM PAUSE
	return true
func _on_cinematic() -> void:
	Manage_MenuBehavior.ref.hide_if_needed()
func _on_previously_cinematic() -> void:
	pass
	
func _check_walking() -> bool:
	return true
func _on_walking() -> void:
	Manage_MenuBehavior.ref.hide_if_needed()
	Manage_Camera.ref.switch(
		Manage_Camera.CAMERAS.WALKING)
func _on_previously_walking() -> void:
	Manage_Walking.ref.change_state(
		Manage_Walking.STATES.NONE)
		
func _check_battle() -> bool:
	return true
func _on_battle() -> void:
	Manage_MenuBehavior.ref.hide_if_needed()
	Manage_Camera.ref.switch(
		Manage_Camera.CAMERAS.BATTLE)
func _on_previously_battle() -> void:
	Manage_Battle.ref.change_state(
		Manage_Battle.STATES.NONE)
