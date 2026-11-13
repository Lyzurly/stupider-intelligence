extends HSplitContainer

@onready var _new_game_button: Button = %NewGame_Button

func _ready() -> void:
	_ready_connections()

func _ready_connections() -> void:
	_new_game_button.pressed.connect(_on_pressed_new_game)
	
func _on_pressed_new_game() -> void:
	Manage_Menus.ref.change_state(
		Manage_Menus.STATES.CREATE_PARTY)
