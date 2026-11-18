class_name Manage_Party extends Node
static var ref: Manage_Party
func _init() -> void:
	ref = self
	
enum CHARACTERS {
	CHARACTER1,
	CHARACTER2,
	CHARACTER3,
	CHARACTER4
	}

enum CLASSES {
	NONE,
	Project_Manager,
	Automation_Dev,
	Backend_Dev,
	Frontend_Dev,
	Full_Stack_Dev,
	Quality_Assurer,
	}

enum CLASS_CONTENT { ## Contnet of _data
	ABILITY_LIST, ## Dictionary
	}
	
enum PARTY_CONTENT { ## Contnet of _data
	ORDER, ## int
	NAME, ## String
	CLASS, ## CLASSES
	}

enum ABILITIES { ## Abilities party members can use
	NAVIGATE,
	BRUTE_FORCE_SOLVER,
	A_STAR_SOLVER,
	FIGHT_BUG,
	PROGRAM_PATH,
	OPTIMIZE,
	WEAKEN_BUG,
	REVEAL_PATH
	}

const _CLASS_DATA: Dictionary[CLASSES,Dictionary] = {
	CLASSES.Project_Manager: {
		CLASS_CONTENT.ABILITY_LIST: {
			ABILITIES.OPTIMIZE:{},
			ABILITIES.REVEAL_PATH:{},
		},
	},
	CLASSES.Automation_Dev: {
		CLASS_CONTENT.ABILITY_LIST: {
			ABILITIES.BRUTE_FORCE_SOLVER:{},
			ABILITIES.A_STAR_SOLVER:{},
		},
	},
	CLASSES.Backend_Dev: {
		CLASS_CONTENT.ABILITY_LIST: {
			ABILITIES.PROGRAM_PATH:{},
			ABILITIES.FIGHT_BUG:{},
		},
	},
	CLASSES.Frontend_Dev: {
		CLASS_CONTENT.ABILITY_LIST: {
			ABILITIES.NAVIGATE:{},
			ABILITIES.FIGHT_BUG:{},
		},
	},
	CLASSES.Full_Stack_Dev: {
		CLASS_CONTENT.ABILITY_LIST: {
			ABILITIES.BRUTE_FORCE_SOLVER:{},
			ABILITIES.PROGRAM_PATH:{},
			ABILITIES.NAVIGATE:{},
			ABILITIES.FIGHT_BUG:{},
		},
	},
	CLASSES.Quality_Assurer: {
		CLASS_CONTENT.ABILITY_LIST: {
			ABILITIES.OPTIMIZE:{},
			ABILITIES.WEAKEN_BUG:{},
		},
	},
	}

var _party_data: Dictionary[CHARACTERS,Dictionary] = {
	CHARACTERS.CHARACTER1:{
		PARTY_CONTENT.ORDER: 1,
		PARTY_CONTENT.NAME: "",
		PARTY_CONTENT.CLASS: CLASSES.NONE,
	},
	CHARACTERS.CHARACTER2:{
		PARTY_CONTENT.ORDER: 2,
		PARTY_CONTENT.NAME: "",
		PARTY_CONTENT.CLASS: CLASSES.NONE,
	},
	CHARACTERS.CHARACTER3:{
		PARTY_CONTENT.ORDER: 3,
		PARTY_CONTENT.NAME: "",
		PARTY_CONTENT.CLASS: CLASSES.NONE,
	},
	CHARACTERS.CHARACTER4:{
		PARTY_CONTENT.ORDER: 4,
		PARTY_CONTENT.NAME: "",
		PARTY_CONTENT.CLASS: CLASSES.NONE,
	},
}

func get_party_data() -> Dictionary[CHARACTERS,Dictionary]:
	return _party_data

func set_party_data_content(
who:CHARACTERS,
what:PARTY_CONTENT,
to:Variant) -> void:
	_party_data[who][what] = to

func get_party_data_content(
who:CHARACTERS,
what:PARTY_CONTENT,
) -> Variant:
	return _party_data[who][what]
 
func get_class_from_int(from:int) -> CLASSES:
	var class_to_return: CLASSES = \
		CLASSES.NONE
	match from:
		1: class_to_return = CLASSES.Project_Manager
		2: class_to_return = CLASSES.Automation_Dev
		3: class_to_return = CLASSES.Backend_Dev
		4: class_to_return = CLASSES.Frontend_Dev
		5: class_to_return = CLASSES.Full_Stack_Dev
		6: class_to_return = CLASSES.Quality_Assurer
	return class_to_return
	
func all_names_set() -> bool:
	var chosen: bool = true
	var chosen_names: Array[String] = []
	var party_data: Dictionary[CHARACTERS,Dictionary] = \
		ref.get_party_data()
	
	for character in party_data:
		var chosen_name: String = \
			party_data[character][
			PARTY_CONTENT.NAME] 
		chosen_names.append(chosen_name)
	
	for chosen_name in chosen_names:
		if chosen_name == "":
			print(chosen_names)
			return false
		
	
	return chosen
	

func all_classes_chosen() -> bool:
	var chosen: bool = true
	var chosen_classes: Array[CLASSES] = []
	var party_data: Dictionary[CHARACTERS,Dictionary] = \
		ref.get_party_data()
	
	for character in party_data:
		var chosen_class: CLASSES = \
			party_data[character][
			PARTY_CONTENT.CLASS] 
		chosen_classes.append(chosen_class)
	
	for chosen_class in chosen_classes:
		if chosen_class == CLASSES.NONE:
			print(chosen_classes)
			return false
	
	return chosen
