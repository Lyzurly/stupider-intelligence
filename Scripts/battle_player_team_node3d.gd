extends Node3D

@onready var _slot1_name_label: Label3D = %Char1Name_Label3D
@onready var _slot2_name_label: Label3D = %Char2Name_Label3D
@onready var _slot3_name_label: Label3D = %Char3Name_Label3D
@onready var _slot4_name_label: Label3D = %Char4Name_Label3D

func _ready() -> void:
	_ready_char_names()
	
func _ready_char_names() -> void:
	#_slot1_name_label.text = \
		#Manage_Party.ref.get_party_data(
			#Manage_Party.CHARACTERS.CHARACTER1
	
	var party_data: Dictionary[Manage_Party.CHARACTERS,Dictionary] = \
		Manage_Party.ref.get_party_data()
		
	for character in party_data.keys():
		var charname: String = \
			party_data[character][
			Manage_Party.PARTY_CONTENT.NAME]
		var order: int = \
			party_data[character][
			Manage_Party.PARTY_CONTENT.ORDER]
			
		match order:
			1: _slot1_name_label.text = \
				charname
			2: _slot2_name_label.text = \
				charname
			3: _slot3_name_label.text = \
				charname
			4: _slot4_name_label.text = \
				charname
