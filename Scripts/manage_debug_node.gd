class_name Manage_Debug extends Node
static var ref: Manage_Debug
func _init() -> void:
	ref = self
	if not OS.is_debug_build():
		queue_free()

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_B:
			Manage_BattleScene.ref.switch(
				Manage_BattleScene.BATTLE_SCENES.BATTLE_1)
			print("BATTLE SYSTEM ENGAGE!")
