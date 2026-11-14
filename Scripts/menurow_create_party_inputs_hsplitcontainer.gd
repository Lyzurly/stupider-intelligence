@abstract class_name MenuRow_CreateParty_Inputs extends Control


@abstract func _name1_textbox() -> LineEdit
@abstract func _name2_textbox() -> LineEdit

@abstract func _class1_dropdown() -> OptionButton
@abstract func _class2_dropdown() -> OptionButton

@abstract func _on_name1_changed(to:String) -> void
		
@abstract func _on_name2_changed(to:String) -> void

@abstract func _on_class1_chosen(id:int) -> void

@abstract func _on_class2_chosen(id:int) -> void

func _ready() -> void:
	_ready_class_lists()
	_ready_connections()

func _ready_connections() -> void:
	_name1_textbox().text_changed.connect(_on_name1_changed)
	_name2_textbox().text_changed.connect(_on_name2_changed)
	
	_class1_dropdown().item_selected.connect(_on_class1_chosen)
	_class2_dropdown().item_selected.connect(_on_class2_chosen)

	
func _ready_class_lists() -> void:
	for class_string in \
	Manage_Party.CLASSES.keys():
		if class_string == "NONE":
			continue
		_class1_dropdown().add_item(class_string)
		_class2_dropdown().add_item(class_string)
		
		
	
