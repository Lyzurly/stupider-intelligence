class_name Manage_BattleParty extends Node
static var ref: Manage_BattleParty
func _init() -> void:
	ref = self

var _current_attacker: Manage_Party.CHARACTERS = Manage_Party.CHARACTERS.NONE
var _current_ability: Manage_Abilities.ABILITIES = Manage_Abilities.ABILITIES.NONE

func get_current_attacker() -> Manage_Party.CHARACTERS:
	print("Getting CURRENT attacker... ", Manage_Party.CHARACTERS.find_key(_current_attacker))
	return _current_attacker
func set_current_attacker(attacker: Manage_Party.CHARACTERS) -> void:
	print("Set CURRENT attacker to: ", Manage_Party.CHARACTERS.find_key(attacker))
	_current_attacker = attacker
	
	
func get_current_ability() -> Manage_Abilities.ABILITIES:
	return _current_ability
func set_current_ability(ability: Manage_Abilities.ABILITIES) -> void:
	_current_ability = ability
