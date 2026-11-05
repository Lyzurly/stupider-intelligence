class_name Manage_Menus extends Node
static var ref: Manage_Menus
func _init() -> void:
	ref = self
	
@onready var _canvas_layer: CanvasLayer = %Menus_CanvasLayer
@onready var _button_start: Button = %StartGame_Button

func _ready() -> void:
	_ready_connections()
	
func _ready_connections() -> void:
	_button_start.pressed.connect(_on_start_pressed)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Pause"):
		Manage_Game.ref.game_state(
			Manage_Game.STATES.MENUS)

func show_if_needed() -> void:
	if not _canvas_layer.visible:
		_canvas_layer.visible = true
func hide_if_needed() -> void:
	if _canvas_layer.visible:
		_canvas_layer.visible = false

func _on_start_pressed() -> void:
	Manage_Cinematics.ref.switch(
		Manage_Cinematics.CINEMATICS.CINEMATIC_1)
