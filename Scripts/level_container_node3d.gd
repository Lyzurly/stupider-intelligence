class_name Level_Container extends Node3D
static var ref: Level_Container
func _init() -> void:
	ref = self
	
const _PLAYER_SCENE: PackedScene = preload("uid://ddj6t6pm1wpst")
	
var _current_level: Level = null
var _current_level_type: Manage_Level.LEVEL_TYPES = \
	Manage_Level.LEVEL_TYPES.NONE


#region "Camera" rotation ======================
const ROT_MIN: float = -45.
const ROT_MAX: float = 315
var rot_amount: float = 0. # dir represented by lerp b/n -1 to 1
#endregion -------------------------------------

func _input(event: InputEvent) -> void:
	_input_rotation(event)

func show_if_needed() -> void:
	if not visible:
		visible = true
		
func load_level(
type:Manage_Level.LEVEL_TYPES,which:PackedScene
) -> void:
	var approved: bool = false
	
	#region State approval check =======================
	match type:
		Manage_Level.LEVEL_TYPES.CINEMATIC: \
			approved = Manage_Game.ref.change_state(
				Manage_Game.STATES.CINEMATIC)
		Manage_Level.LEVEL_TYPES.OVERWORLD: \
			approved = Manage_Walking.ref.change_state(
				Manage_Walking.STATES.OVERWORLD)
		Manage_Level.LEVEL_TYPES.UNDERWORLD: \
			approved = Manage_Walking.ref.change_state(
				Manage_Walking.STATES.UNDERWORLD)
		Manage_Level.LEVEL_TYPES.BATTLE_SCENE: \
			approved = Manage_Battle.ref.change_state(
				Manage_Battle.STATES.INTRO)
	
	if not approved:
		return
	#endregion --------------------------------------
		
	var scene: Node3D = \
		which.instantiate()
	var level: Level = \
		scene as Level
	
	destroy_level()
	
	#region Player spawn check =======================
	match type:
		Manage_Level.LEVEL_TYPES.OVERWORLD, \
		Manage_Level.LEVEL_TYPES.UNDERWORLD:
			var player: Node3D = \
				_PLAYER_SCENE.instantiate()
			level.add_child(player)
	#endregion --------------------------------------
	
	_current_level = level
	add_child(level)
	
	
	#region Level-loaded actions =======================
	match type:
		Manage_Level.LEVEL_TYPES.CINEMATIC: 
			if not level is Cinematic:
				push_error("Uh oh tried to instantiate a cinematic that ain't a cinematic: ",level)
				return
				
			var cinematic: Cinematic = level as Cinematic
			cinematic.start()
			
		Manage_Level.LEVEL_TYPES.OVERWORLD: \
			pass
		Manage_Level.LEVEL_TYPES.UNDERWORLD: \
			pass
		Manage_Level.LEVEL_TYPES.BATTLE_SCENE: \
			pass
		#endregion --------------------------------------

func destroy_level() -> void:
	if not _current_level:
		return
	_current_level.queue_free()
	_current_level = null


func _input_rotation(event:InputEvent) -> void:
	if Input.is_action_just_pressed("Clockwise"):
			rot_amount = 1.
	elif Input.is_action_just_pressed("CounterClockwise"):
			rot_amount = -1.
	else:
		return
	
	var clamprot: float = clamp(
			global_rotation.y + rot_amount,
			ROT_MIN,ROT_MAX)
	
	if clamprot < ROT_MIN:
		clamprot = ROT_MAX
	elif clamprot > ROT_MAX:
		clamprot = ROT_MIN 

	global_rotation.y = lerp(
		global_rotation.y,clamprot,.6)	
		
	Camera_Walking.ref.set_lerp_speed(1.)
		

	
