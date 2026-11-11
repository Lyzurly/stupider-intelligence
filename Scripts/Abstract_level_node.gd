@abstract class_name Manage_Level extends Node

@abstract func _my_type() -> LEVEL_TYPES

const _BATTLE_CONTAINER_SCENE: PackedScene = preload("uid://d2672tsns0pfy")

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
	
func get_new_battle() -> PackedScene:
	return _BATTLE_CONTAINER_SCENE

func _load_level(
level_scene:PackedScene,enviro_scene:PackedScene
) -> void:
	Level_Container.ref.load_level(
		_my_type(),level_scene,enviro_scene)

			
				
