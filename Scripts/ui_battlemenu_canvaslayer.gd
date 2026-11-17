class_name Battle_Menu extends CanvasLayer
static var ref: Battle_Menu
func _init() -> void:
	ref = self

@onready var _menu_timer: Timer = %BattleMenu_Timer

@onready var _intro_text_container: MarginContainer = %IntroText_MenuBox_MarginContainer
@onready var _gameplay_menu_container: MarginContainer = %GameplayMenu_MarginContainer
@onready var _opponent_menu_container: MarginContainer = %OpponentMenu_MarginContainer

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
