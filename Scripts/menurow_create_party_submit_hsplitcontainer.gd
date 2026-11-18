extends HSplitContainer

@onready var _button_start: Button = %StartGame_Button

func _ready() -> void:
	_ready_start_button()
	_ready_connections()
	
func _ready_start_button() -> void:
	_button_start.disabled = true
	
func _ready_connections() -> void:
	Manage_MenuBehavior.ref.a_create_party_property_was_set.connect(
		_on_a_create_party_property_set)
	_button_start.pressed.connect(_on_start_pressed)
	
func _on_a_create_party_property_set() -> void:
	var can_start: bool = \
		Manage_Party.ref.all_classes_chosen() \
		and	Manage_Party.ref.all_names_set()
	
	_button_start.disabled = not can_start
		
	
func _on_start_pressed() -> void:
	Manage_Game.ref.change_state(
		Manage_Game.STATES.CINEMATIC)
