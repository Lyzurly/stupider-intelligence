@abstract class_name Manage_Level extends Node

enum LEVEL_TYPES {
	NONE,
	CINEMATIC,
	OVERWORLD,
	UNDERWORLD
	}
	
enum LEVEL_CONTENT {
	SCENE, # PackedScene
	}

@abstract func _my_type() -> LEVEL_TYPES

func _load_level(which:PackedScene) -> void:
	Level_Container.ref.load_level(
		_my_type(),which)

			
				
