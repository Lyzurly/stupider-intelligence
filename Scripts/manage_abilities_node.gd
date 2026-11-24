class_name Manage_Abilities extends Node
static var ref: Manage_Abilities
func _init() -> void:
	ref = self

signal ability_chosen(which:ABILITIES)

var _current: ABILITIES = ABILITIES.NONE
enum ABILITIES { ## Abilities party members can use
	NONE,
	Navigate,
	Auto_Navigate,
	#Brute_Force_Solver,
	#A_Star_Solver,
	Fight_Bug,
	Program_Path,
	Optimize,
	Weaken_Bug,
	Reveal_Path
	}

func get_current() -> ABILITIES:
	return _current
func set_current_by_enum(to: ABILITIES) -> void:
	_current = to
	ability_chosen.emit(_current)

func set_current_by_string(to: String) -> void:
	var abil_enum_index: int = \
		ABILITIES[to]
	var abil_enum_entry: ABILITIES = \
		abil_enum_index as ABILITIES
	set_current_by_enum(abil_enum_entry)
