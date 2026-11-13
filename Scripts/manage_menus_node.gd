class_name Manage_Menus extends Node
static var ref: Manage_Menus
func _init() -> void:
	ref = self
	
var _state: STATES = STATES.NONE
enum STATES{
	NONE,
	MAIN,
	CREATE_PARTY,
	PAUSE,
	SHOPPING,
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
		STATES.MAIN:
			change_approved = _check_main()
		STATES.CREATE_PARTY:
			change_approved = _check_create_party()
		STATES.PAUSE:
			change_approved = _check_pause()
		STATES.SHOPPING:
			change_approved = _check_shopping()
	
	change_approved = Manage_Game.ref.change_state(
						Manage_Game.STATES.MENUS)
		
	if change_approved:
			
		match to:
			STATES.NONE:
				_on_none()
			STATES.MAIN:
				_on_main()
			STATES.CREATE_PARTY:
				_on_create_party()
			STATES.PAUSE:
				_on_pause()
			STATES.SHOPPING:
				_on_shopping()
		_state = to
		print("MENU STATE: ",STATES.find_key(_state))
	else:
		print("REJECTED: MENU STATE: ",STATES.find_key(_state))

	return change_approved	
		
func _check_none() -> bool:
	return true
func _on_none() -> void:
	pass

func _check_main() -> bool:
	var approved: bool
	
	if Manage_Game.ref.is_state(
	Manage_Game.STATES.NONE) \
	and \
	Manage_Game.ref.is_previous_state(
	Manage_Game.STATES.NONE):
		approved = true
	else:
		approved = false
		
	return approved
func _on_main() -> void:
	Manage_MenuBehavior.ref.create_new_menu(
		Manage_MenuBehavior.ROW_SCENES.NONE,
		Manage_MenuBehavior.ROW_SCENES.NEW_OR_LOAD_GAME)
	Manage_MenuBehavior.ref.show_if_needed()

func _check_create_party() -> bool:
	return true
func _on_create_party() -> void:
	Manage_MenuBehavior.ref.create_new_menu(
		Manage_MenuBehavior.ROW_SCENES.NONE,
		Manage_MenuBehavior.ROW_SCENES.NONE,
		Manage_MenuBehavior.ROW_SCENES.NONE,
		Manage_MenuBehavior.ROW_SCENES.CREATE_CLASS)
	Manage_MenuBehavior.ref.show_if_needed()
		
func _check_pause() -> bool:
	var approved: bool = false
	
	if Manage_Game.ref.is_state(
	Manage_Game.STATES.MENUS) \
	and \
	Manage_Game.ref.is_previous_state(
	Manage_Game.STATES.WALKING):
		Manage_Walking.ref.change_to_previous()

	if Manage_Game.ref.is_state(
	Manage_Game.STATES.WALKING):
		Manage_MenuBehavior.ref.show_if_needed()
		Player.ref.lock_movement(true)
		approved = true
	
	return approved
func _on_pause() -> void:
	await get_tree().process_frame
	Level_Container.ref.show_if_needed()
		
func _check_shopping() -> bool:
	return true
func _on_shopping() -> void:
	pass

func _check_lost() -> bool:
	return true
func _on_lost() -> void:
	pass
