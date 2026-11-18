class_name Manage_BattleParty extends Node
static var ref: Manage_BattleParty
func _init() -> void:
	ref = self

var _current_attacker: Manage_Party.CHARACTERS = Manage_Party.CHARACTERS.NONE

func get_current_attacker() -> Manage_Party.CHARACTERS:
	return _current_attacker
func set_current_attacker(attacker: Manage_Party.CHARACTERS) -> void:
	_current_attacker = attacker
