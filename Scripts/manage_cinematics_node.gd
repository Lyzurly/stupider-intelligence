class_name Manage_Cinematics extends Manage_Level
static var ref: Manage_Cinematics
func _init() -> void:
	ref = self

enum CINEMATICS {
	NONE,
	CINEMATIC_1,CINEMATIC_2,CINEMATIC_3,CINEMATIC_4,CINEMATIC_5,
	}
var _current: CINEMATICS = CINEMATICS.NONE

var _skip_desired: bool = false

var _data: Dictionary[CINEMATICS,Dictionary] = {
	CINEMATICS.NONE:{},
	CINEMATICS.CINEMATIC_1:{
		Manage_Level.LEVEL_CONTENT.SCENE: preload("uid://bnt4tq6t4bjse"),
		Manage_Level.LEVEL_CONTENT.ENVIRONMENT: preload("uid://dsvi7knyt542x")
	},
	CINEMATICS.CINEMATIC_2:{
		Manage_Level.LEVEL_CONTENT.SCENE: preload("uid://brhmirj3boin0"),
		Manage_Level.LEVEL_CONTENT.ENVIRONMENT: preload("uid://cnm5yt6strlkn")
	},
	CINEMATICS.CINEMATIC_3:{
		Manage_Level.LEVEL_CONTENT.SCENE: preload("uid://bpo6svotutiqm"),
		Manage_Level.LEVEL_CONTENT.ENVIRONMENT: preload("uid://7wq1ynucwryt")
	},
	CINEMATICS.CINEMATIC_4:{
		Manage_Level.LEVEL_CONTENT.SCENE: preload("uid://bcswdbeeh35ij"),
		Manage_Level.LEVEL_CONTENT.ENVIRONMENT: preload("uid://d1jwibgil1eeh")
	},
}

func _ready_instance() -> void:
	_ready_connections()

func _ready_connections() -> void:
	Manage_Input.ref.skip_begun.connect(_on_skip_pressed)

func _my_type() -> LEVEL_TYPES:
	return LEVEL_TYPES.CINEMATIC

func switch(to:CINEMATICS) -> void:
	_load_level(
		_data[to][LEVEL_CONTENT.SCENE],
		_data[to][LEVEL_CONTENT.ENVIRONMENT],
	)
		
func get_current() -> CINEMATICS:
	return _current

func set_current(to:CINEMATICS) -> void:
	_current = to
	
func get_skip_desirability() -> bool:
	return _skip_desired
func reset_skip_desirability() -> void:
	_skip_desired = false

func _on_skip_pressed() -> void:
	_skip_desired = true
