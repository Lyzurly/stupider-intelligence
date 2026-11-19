class_name Manage_Instantiation extends Node
static var ref: Manage_Instantiation
func _init() -> void:
	ref = self

enum INSTANCES {
	NON_SPECIFIC,
	BATTLE_MENU
}
	
func instantiate_something(
what:PackedScene,
specifically:INSTANCES = INSTANCES.NON_SPECIFIC,
) -> Variant:	
	if not specifically == INSTANCES.NON_SPECIFIC:
		match specifically:
			INSTANCES.BATTLE_MENU:
				if is_instance_valid(Battle_Menu.ref):
					_duplicate_instance_attempted(specifically)
					return null
	
	var something: Variant = what.instantiate()
	print_rich("[b]Instantiating ",something.name," from ",what,"...")
	
	return something
	
func _duplicate_instance_attempted(
which:INSTANCES) -> void:
	push_error("UH OH LYZ a ",
	INSTANCES.find_key(which),
	" instance is tryna double up whoopsssss, here's the stack:")
	print_stack()
