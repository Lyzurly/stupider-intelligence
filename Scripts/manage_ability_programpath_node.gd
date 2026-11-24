class_name Manage_Ability_ProgramPath extends Node
static var ref: Manage_Ability_ProgramPath
func _init() -> void:
	ref = self
	
signal programming(arrow:Programmed_Arrow)

const _PROGRAM_ARROW: PackedScene = preload("uid://b3c4jeosh1njc")
var _current_arrow: Programmed_Arrow

var _is_programming: bool = false

func _ready() -> void:
	_ready_connections()

func _ready_connections() -> void:
	Manage_Abilities.ref.ability_chosen.connect(_on_ability_chosen)
	
func get_current_arrow() -> Programmed_Arrow:
	return _current_arrow

func change_state(indeed_programming:bool) -> void:
	_is_programming = indeed_programming
	if _is_programming:
		_on_is_programming()
	else:
		_on_is_not_programming()

func is_programming() -> bool:
	return _is_programming
	
func _on_ability_chosen(ability:Manage_Abilities.ABILITIES) -> void:
	if ability == Manage_Abilities.ABILITIES.Program_Path:
		Manage_Ability_ProgramPath.ref.change_state(true)

func _on_is_programming() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	var arrow: Programmed_Arrow = \
		_PROGRAM_ARROW.instantiate()
		
	_current_arrow = arrow
	
	programming.emit(arrow)
	
func _on_is_not_programming() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	_current_arrow = null
