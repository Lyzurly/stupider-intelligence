class_name Manage_MenuBehavior extends Node
static var ref: Manage_MenuBehavior
func _init() -> void:
	ref = self

enum ROW_SCENES {
	NONE,
	GENERIC,
	NEW_OR_LOAD_GAME,
	CREATE_CLASS,
	}

const _ROW_SCENE_GENERIC: PackedScene = preload("uid://g61yy80letg6")
const _ROW_SCENE_NEW_OR_LOAD_GAME: PackedScene = preload("uid://dl2uv1stbq2ss")
const _ROW_SCENE_CREATE_CLASS: PackedScene = preload("uid://bc65ipkw17pjw")
	
@onready var _canvas_layer: CanvasLayer = %Menus_CanvasLayer

@onready var _row1_container: PanelContainer = %Row1_PanelContainer
@onready var _row2_container: PanelContainer = %Row2_PanelContainer
@onready var _row3_container: PanelContainer = %Row3_PanelContainer
@onready var _row4_container: PanelContainer = %Row4_PanelContainer

var _row_scene_data: Dictionary[ROW_SCENES,PackedScene] = {
	ROW_SCENES.NONE: null,
	ROW_SCENES.GENERIC: _ROW_SCENE_GENERIC,
	ROW_SCENES.NEW_OR_LOAD_GAME: _ROW_SCENE_NEW_OR_LOAD_GAME,
	ROW_SCENES.CREATE_CLASS: _ROW_SCENE_CREATE_CLASS,
	}

var _current_row_nodes: Array[HSplitContainer] = []

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Pause"):
		Manage_Menus.ref.change_state(
			Manage_Menus.STATES.PAUSE)

func create_new_menu(
row1:ROW_SCENES=ROW_SCENES.NONE,
row2:ROW_SCENES=ROW_SCENES.NONE,
row3:ROW_SCENES=ROW_SCENES.NONE,
row4:ROW_SCENES=ROW_SCENES.NONE,
) -> void:
	for row_node in _current_row_nodes:
		row_node.queue_free()
	
	if not row1 == ROW_SCENES.NONE:
		var row1_node: HSplitContainer = \
			_row_scene_data[row1].instantiate() as HSplitContainer
		_row1_container.add_child(row1_node)
		_current_row_nodes.append(row1_node)
	
	if not row2 == ROW_SCENES.NONE:
		var row2_node: HSplitContainer = \
			_row_scene_data[row2].instantiate() as HSplitContainer
		_row2_container.add_child(row2_node)
		_current_row_nodes.append(row2_node)
	
	if not row3 == ROW_SCENES.NONE:
		var row3_node: HSplitContainer = \
			_row_scene_data[row3].instantiate() as HSplitContainer
		_row3_container.add_child(row3_node)
		_current_row_nodes.append(row3_node)
	
	if not row4 == ROW_SCENES.NONE:
		var row4_node: HSplitContainer = \
			_row_scene_data[row4].instantiate() as HSplitContainer
		_row4_container.add_child(row4_node)
		_current_row_nodes.append(row4_node)

func show_if_needed() -> void:
	if not _canvas_layer.visible:
		_canvas_layer.visible = true
func hide_if_needed() -> void:
	if _canvas_layer.visible:
		_canvas_layer.visible = false
