class_name Battle_Menu extends CanvasLayer
static var ref: Battle_Menu
func _init() -> void:
	ref = self
	
#signal next_player_attacker_ready(
	#attacker_name:String,
	#attacker_class: Manage_Party.CLASSES)

@onready var _menu_timer: Timer = %BattleMenu_Timer

@onready var _intro_text_container: MarginContainer = %IntroText_MenuBox_MarginContainer
@onready var _gameplay_menu_container: MarginContainer = %GameplayMenu_MarginContainer
@onready var _opponent_menu_container: MarginContainer = %OpponentMenu_MarginContainer

@onready var _char_name_label: Label = %CharName_Label

@onready var _abil_1_button: Button = %Abil_1_Button
@onready var _abil_2_button: Button = %Abil_2_Button
@onready var _abil_3_button: Button = %Abil_3_Button
@onready var _abil_4_button: Button = %Abil_4_Button

var _last_known_state: Manage_Battle.STATES = Manage_Battle.STATES.NONE	

func _ready() -> void:
	print("BattleMenu CanvasLayer created")
	_ready_visibilities()
	_ready_connections()
	
func _ready_visibilities() -> void:
	_on_any()

func _ready_connections() -> void:
	_menu_timer.timeout.connect(_on_menu_timer_timeout)
	_abil_1_button.pressed.connect(_on_abil_1_pressed)
	_abil_2_button.pressed.connect(_on_abil_2_pressed)
	_abil_3_button.pressed.connect(_on_abil_3_pressed)
	_abil_4_button.pressed.connect(_on_abil_4_pressed)

func show_menu(
to_show:Manage_Battle.STATES,
#to_hide:Manage_Battle.STATES
) -> void:
	_on_any()
	_last_known_state = to_show
	match to_show:
		Manage_Battle.STATES.INTRO:
			_on_intro()
		Manage_Battle.STATES.GAMEPLAY:
			_on_gameplay()
		Manage_Battle.STATES.WON:
			_on_won()
		Manage_Battle.STATES.LOST:
			_on_lost()

func _on_menu_timer_timeout() -> void:
	print("MENU TIMER TIMEOUT")
	_menu_timer.stop()
	if _last_known_state == Manage_Battle.STATES.NONE:
		push_error("Wait um why is the last known state none lmfao")
		
	match _last_known_state:
		Manage_Battle.STATES.INTRO:
			_after_intro()
		Manage_Battle.STATES.GAMEPLAY:
			_after_gameplay()
		Manage_Battle.STATES.WON:
			_after_won()
		Manage_Battle.STATES.LOST:
			_after_lost()

func _after_intro() -> void:
	Manage_Battle.ref.change_state(
		Manage_Battle.STATES.GAMEPLAY)
	
func _after_gameplay() -> void:
	pass
	
func _after_won() -> void:
	pass
	
func _after_lost() -> void:
	pass
			
func _on_any() -> void:
	_on_intro(false)
	_on_gameplay(false)
	_on_won(false)
	_on_lost(false)

func _on_intro(do_show:bool = true) -> void:
	_intro_text_container.visible = do_show
	_menu_timer.start(3)

func _on_gameplay(do_show:bool = true) -> void:
	_prepare_next_player_attacker()
	_gameplay_menu_container.visible = do_show
	_opponent_menu_container.visible = do_show

func _on_won(do_show:bool = true) -> void:
	pass

func _on_lost(do_show:bool = true) -> void:
	pass
	
func _on_abil_1_pressed() -> void:
	pass
func _on_abil_2_pressed() -> void:
	pass
func _on_abil_3_pressed() -> void:
	pass
func _on_abil_4_pressed() -> void:
	pass

#region Ability Menu Stuff ==========================
func _update_current_attacker_name(to:String) -> void:
	_char_name_label.text = to
	
func _update_current_attacker_class(
to:Manage_Party.CLASSES
) -> void:
	var ability_array: Array[Manage_Party.ABILITIES] = []
	var ability_dictionary: Dictionary = \
		Manage_Party.ref.get_class_data_content(
			to,
			Manage_Party.CLASS_CONTENT.ABILITY_LIST)
	
	for ability: Manage_Party.ABILITIES in ability_dictionary:
		ability_array.append(ability)
	
	var ability_count: int = ability_array.size()
	
	for count in ability_count:
		var ability_enum_string: String = \
			Manage_Party.ABILITIES.find_key(ability_array[count])
		var ability_name_string: String = \
			ability_enum_string.replace("_"," ")
			
		if count == 0:
			_abil_1_button.text = ability_name_string
		elif count == 1:
			_abil_2_button.text = ability_name_string
		elif count == 2:
			_abil_3_button.text = ability_name_string
		elif count == 3:
			_abil_4_button.text = ability_name_string
	
func _prepare_next_player_attacker() -> void:
	var next_attacker_name: String
	var next_attacker_class: Manage_Party.CLASSES = \
		Manage_Party.CLASSES.NONE
	
	var party_data: Dictionary[Manage_Party.CHARACTERS,Dictionary] = \
		Manage_Party.ref.get_party_data()
	
	const INF_ORDER: int = 999999999999999999
	var next_attacker_order: int = INF_ORDER
	var next_attacker: Manage_Party.CHARACTERS = \
		Manage_BattleParty.ref.get_current_attacker() 
		
	if next_attacker == Manage_Party.CHARACTERS.NONE:
		for party_character: Manage_Party.CHARACTERS \
		in party_data:
			var current_attacker_order: int = \
				party_data[party_character][
				Manage_Party.PARTY_CONTENT.ORDER]
			var current_attacker_is_alive: bool = \
				party_data[party_character][
				Manage_Party.PARTY_CONTENT.ALIVE]
			if current_attacker_order < next_attacker_order \
			and current_attacker_is_alive:
				next_attacker_order = current_attacker_order
				
				next_attacker = party_character
			
				next_attacker_name = \
					party_data[party_character][
					Manage_Party.PARTY_CONTENT.NAME]
				next_attacker_class = \
					party_data[party_character][
					Manage_Party.PARTY_CONTENT.CLASS]
			else:
				continue
					
		assert(not next_attacker_order == INF_ORDER,
		"Uh oh you didn't find the order of the next attacker, is everyone dead lmao?")
	
		assert(not next_attacker == Manage_Party.CHARACTERS.NONE,
		"Oh dearie me, you didn't find a next attacker at all, is everyone dead lmao?")
		_update_current_attacker_name(next_attacker_name)
		_update_current_attacker_class(next_attacker_class)
		
		#next_player_attacker_ready.emit(
			#next_attacker_name,next_attacker_class)
			
		
		
				
#endregion --------------------------------------------
