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
	PROJECT_MANAGER,
	AUTOMATION_DEV,
	BACKEND_DEV,
	FRONTEND_DEV,
	FULL_STACK_DEV,
	QUALITY_ASSURER,
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
	CLASSES.PROJECT_MANAGER: {
		CLASS_CONTENT.ABILITY_LIST: {
			ABILITIES.OPTIMIZE:{},
			ABILITIES.REVEAL_PATH:{},
		},
	},
	CLASSES.AUTOMATION_DEV: {
		CLASS_CONTENT.ABILITY_LIST: {
			ABILITIES.BRUTE_FORCE_SOLVER:{},
			ABILITIES.A_STAR_SOLVER:{},
		},
	},
	CLASSES.BACKEND_DEV: {
		CLASS_CONTENT.ABILITY_LIST: {
			ABILITIES.PROGRAM_PATH:{},
			ABILITIES.FIGHT_BUG:{},
		},
	},
	CLASSES.FRONTEND_DEV: {
		CLASS_CONTENT.ABILITY_LIST: {
			ABILITIES.NAVIGATE:{},
			ABILITIES.FIGHT_BUG:{},
		},
	},
	CLASSES.FULL_STACK_DEV: {
		CLASS_CONTENT.ABILITY_LIST: {
			ABILITIES.BRUTE_FORCE_SOLVER:{},
			ABILITIES.PROGRAM_PATH:{},
			ABILITIES.NAVIGATE:{},
			ABILITIES.FIGHT_BUG:{},
		},
	},
	CLASSES.QUALITY_ASSURER: {
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
	print("\n\nsetting ",CHARACTERS.find_key(who),"'s ",PARTY_CONTENT.find_key(what)," to ",to,"...")
	print_stack()
	_party_data[who][what] = to

func get_party_data_content(
who:CHARACTERS,
what:PARTY_CONTENT,
) -> Variant:
	return _party_data[who][what]
 

func get_class_from_int(from:int) -> CLASSES:
	var class_to_retrun: CLASSES = \
		CLASSES.NONE
	match from:
		1: class_to_retrun = CLASSES.PROJECT_MANAGER
		2: class_to_retrun = CLASSES.AUTOMATION_DEV
		3: class_to_retrun = CLASSES.BACKEND_DEV
		4: class_to_retrun = CLASSES.FRONTEND_DEV
		5: class_to_retrun = CLASSES.FULL_STACK_DEV
		6: class_to_retrun = CLASSES.QUALITY_ASSURER
	return class_to_retrun
