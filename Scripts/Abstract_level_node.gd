@abstract class_name Manage_Level extends Node

@abstract func _my_type() -> LEVEL_TYPES

enum LEVEL_TYPES {
	NONE,
	CINEMATIC,
	OVERWORLD,
	UNDERWORLD,
	BATTLE_SCENE,
	}
	
enum LEVEL_CONTENT {
	SCENE, # PackedScene
	ENVIRONMENT, # PackedScene
	}

func _load_level(
level_scene:PackedScene,enviro_scene:PackedScene
) -> void:
	var approved: bool = false
	match _my_type():
		LEVEL_TYPES.CINEMATIC:
			approved = Manage_Game.ref.is_state(
				Manage_Game.STATES.CINEMATIC)
		LEVEL_TYPES.OVERWORLD:
			approved = Manage_Walking.ref.is_state(
				Manage_Walking.STATES.OVERWORLD)
		LEVEL_TYPES.UNDERWORLD:
			approved = Manage_Walking.ref.is_state(
				Manage_Walking.STATES.UNDERWORLD)
		LEVEL_TYPES.BATTLE_SCENE:
			approved = Manage_Game.ref.is_state(
				Manage_Game.STATES.BATTLE)
	
	assert(
		approved,
		"WHOA WHOA WHOA you are tryna to instantiate a level (" \
			+ str(level_scene) \
			+ ") BEFORE having switched to the state that corresponds to that levels' type (" \
			+ LEVEL_TYPES.find_key(_my_type()) \
			+ ") Trust me, you don't wanna do that."
		)
		
	Level_Container.ref.load_level(
		_my_type(),level_scene,enviro_scene)

			
				
