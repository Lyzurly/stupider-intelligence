extends HSplitContainer

@onready var _button_start: Button = %StartGame_Button

func _ready() -> void:
	_ready_connections()
	
func _ready_connections() -> void:
	_button_start.pressed.connect(_on_start_pressed)
	
func _on_start_pressed() -> void:
	Manage_Cinematics.ref.switch(
		Manage_Cinematics.CINEMATICS.CINEMATIC_1)
