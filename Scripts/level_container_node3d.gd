class_name Level_Container extends Node3D
static var ref: Level_Container
func _init() -> void:
	ref = self
	
const _PLAYER_SCENE: PackedScene = preload("uid://ddj6t6pm1wpst")
	
var _current_level: Level = null
#var _current_level_type: Manage_Level.LEVEL_TYPES = \
	#Manage_Level.LEVEL_TYPES.NONE

func show_if_needed() -> void:
	if not visible:
		visible = true
		
func load_level(
type:Manage_Level.LEVEL_TYPES,
level_scene:PackedScene,
enviro_scene:PackedScene
) -> void:		
	var level_node: Node3D = \
		Manage_Instantiation.ref.instantiate_something(
			level_scene)
	var new_level: Level = \
		level_node as Level
	
	Manage_Environment.ref.set_current_scene(
		enviro_scene)
	var enviro_node: Node3D = \
		Manage_Instantiation.ref.instantiate_something(
			enviro_scene)
	var new_enviro: Level_Environment = \
		enviro_node as Level_Environment
	
	destroy_level()
	
	#region Player spawn check =======================
	match type:
		Manage_Level.LEVEL_TYPES.OVERWORLD, \
		Manage_Level.LEVEL_TYPES.UNDERWORLD:
			var player: Node3D = \
				Manage_Instantiation.ref.instantiate_something(
					_PLAYER_SCENE)
			new_level.add_child(player)
	#endregion --------------------------------------
	
	_current_level = new_level
	add_child(new_level)
	new_level.add_environment(new_enviro)
	
	
	#region Level-loaded actions =======================
	match type:
		Manage_Level.LEVEL_TYPES.CINEMATIC: 
			if not new_level is Cinematic:
				push_error("Uh oh tried to instantiate a cinematic that ain't a cinematic: ",new_level)
				return
				
			var cinematic: Cinematic = new_level as Cinematic
			cinematic.start()
			
		Manage_Level.LEVEL_TYPES.OVERWORLD:
			pass
		Manage_Level.LEVEL_TYPES.UNDERWORLD:
			pass
		Manage_Level.LEVEL_TYPES.BATTLE_SCENE:
			pass
		#endregion --------------------------------------

func destroy_level() -> void:
	if not _current_level:
		return
	_current_level.queue_free()
	_current_level = null

func get_level_rotation() -> Vector3:
	return global_rotation
	
func input_rotation(to:float) -> void:
	global_rotation.y = lerp(
		global_rotation.y,
		to,.6)	
		
	Camera_Walking.ref.set_lerp_speed(1.)
		

	
