class_name Manage_Debug extends Node
static var ref: Manage_Debug
func _init() -> void:
	ref = self
	if not OS.is_debug_build():
		queue_free()
		
func _ready() -> void:
	_ready_connections()
	
func _ready_connections() -> void:
	Manage_Input.ref.pressed_key.connect(_on_pressed_key)

func _on_pressed_key(pressed: Key) -> void:
	if pressed == KEY_B:
			Manage_BattleScene.ref.switch()
			print("BATTLE SYSTEM ENGAGE!")
