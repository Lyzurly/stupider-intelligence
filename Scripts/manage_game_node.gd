class_name Manage_Game extends Node
static var ref: Manage_Game
func _init() -> void:
	ref = self
	
var _game_state: GAME_STATES = GAME_STATES.NONE
enum GAME_STATES{
	NONE,
	MENUS, ## Create Character, Shops, Pause,
	CINEMATIC,
	WALKING, ## Overworld, Location, Custscene
	BATTLE, ## Intro, Gameplay, Win, Lost
	}
	
func _ready() -> void:
	pass
	
func is_state(which:GAME_STATES) -> bool:
	return which == _game_state

func change_game_state(to:GAME_STATES) -> void:
	if _game_state == to:
		return
		
	var change_approved: bool = false
	
	match to:
		GAME_STATES.NONE:
			change_approved = _check_none()
		GAME_STATES.MENUS:
			change_approved = _check_menus()
		GAME_STATES.CINEMATIC:
			change_approved = _check_cinematic()
		GAME_STATES.WALKING:
			change_approved = _check_walking()
		GAME_STATES.BATTLE:
			change_approved = _check_battle()

	
	if change_approved:
		match to:
			GAME_STATES.NONE:
				_on_none()
			GAME_STATES.MENUS:
				_on_menus()
			GAME_STATES.CINEMATIC:
				_on_cinematic()
			GAME_STATES.WALKING:
				_on_walking()
			GAME_STATES.BATTLE:
				_on_battle()
		_game_state = to
		print("GAME STATE: ",GAME_STATES.find_key(_game_state))
	else:
		print("REJECTED: GAME STATE: ",GAME_STATES.find_key(_game_state))
		return
		
func _check_none() -> bool:
	return true
func _on_none() -> void:
	pass

func _check_menus() -> bool:
	if is_state(GAME_STATES.WALKING):
		Manage_Menus.ref.show_if_needed()
		Player.ref.lock_movement(true)
		return true
	return false
func _on_menus() -> void:
	pass
	
func _check_cinematic() -> bool:
	#TODO BLOCK IF COMING FROM PAUSE
	return true
func _on_cinematic() -> void:
	Manage_Menus.ref.hide_if_needed()
	Manage_Cinematics.ref.start()
	
func _check_walking() -> bool:
	return true
func _on_walking() -> void:
	#TODO: CREATE MENU SUBSTATES TO CHECK IF NEWGAME OR PAUSED
	#TODO: CREATE MENU SUBSTATES TO CHECK IF NEWGAME OR PAUSED
	#TODO: CREATE MENU SUBSTATES TO CHECK IF NEWGAME OR PAUSED
	#TODO: CREATE MENU SUBSTATES TO CHECK IF NEWGAME OR PAUSED
	#TODO: CREATE MENU SUBSTATES TO CHECK IF NEWGAME OR PAUSED
	#ALERT DO NOT KEEP "CINEMATIC" HERE LOL?
	if is_state(GAME_STATES.CINEMATIC):
		Manage_Levels.ref.load_level(
			Manage_Levels.LEVELS.OVER_1)
		await get_tree().process_frame
		Player.ref.lock_movement(false)
		Level_Container.ref.show_if_needed()
	elif is_state(GAME_STATES.MENUS):
		Manage_Menus.ref.hide_if_needed()
		Player.ref.lock_movement(false)
		
func _check_battle() -> bool:
	return true
func _on_battle() -> void:
	pass
