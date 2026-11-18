class_name Manage_BattleParty extends Node
static var ref: Manage_BattleParty
func _init() -> void:
	ref = self

var _current_attacker: Manage_Party.CHARACTERS = Manage_Party.CHARACTERS.NONE
var _current_ability: Manage_Party.ABILITIES = Manage_Party.ABILITIES.NONE

func get_current_attacker() -> Manage_Party.CHARACTERS:
	return _current_attacker
func set_current_attacker(attacker: Manage_Party.CHARACTERS) -> void:
	_current_attacker = attacker
	
	
func get_current_ability() -> Manage_Party.ABILITIES:
	return _current_ability
func set_current_ability(ability: Manage_Party.ABILITIES) -> void:
	_current_ability = ability
