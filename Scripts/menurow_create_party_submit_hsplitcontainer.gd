extends HSplitContainer

@onready var _button_start: Button = %StartGame_Button

func _ready() -> void:
	_ready_connections()
	
func _ready_connections() -> void:
	_button_start.pressed.connect(_on_start_pressed)
	
func _on_start_pressed() -> void:
	print("switching to first cinematic...")
	Manage_Game.ref.change_state(
		Manage_Game.STATES.CINEMATIC)
