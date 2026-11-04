@abstract class_name Manage_Levels extends Node
	
enum _LEVEL_TYPES {
	CINEMATIC,
	OVERWORLD,
	UNDERWORLD
	}
enum LEVEL_CONTENT {
	SCENE, # PackedScene
	}

@abstract func _my_type() -> _LEVEL_TYPES

func _load_level(which:PackedScene) -> void:
	var approved: bool = false
	
	match _my_type():
		_LEVEL_TYPES.CINEMATIC: \
			approved = Manage_Game.ref.change_state(
				Manage_Game.STATES.CINEMATIC)
		_LEVEL_TYPES.OVERWORLD: \
			approved = Manage_Walking.ref.change_state(
				Manage_Walking.STATES.OVERWORLD)
		_LEVEL_TYPES.UNDERWORLD: \
			approved = Manage_Walking.ref.change_state(
				Manage_Walking.STATES.UNDERWORLD)
	
	if not approved:
		return
				
	var scene: Node3D = \
		which.instantiate()
		
	Level_Container.ref.add_child(scene)
	
	match _my_type():
		_LEVEL_TYPES.CINEMATIC: 
			if not scene is Cinematic:
				push_error("Uh oh tried to instantiate a cinematic that ain't a cinematic: ",scene)
				return
				
			var cinematic: Cinematic = scene as Cinematic
			cinematic.start()
			
		_LEVEL_TYPES.OVERWORLD: \
			pass
		_LEVEL_TYPES.UNDERWORLD: \
			pass

			
				
