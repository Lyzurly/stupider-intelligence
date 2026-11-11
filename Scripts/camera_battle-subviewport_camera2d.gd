class_name Camera_Battle_SV_Opponent extends Camera_Battle_Subviewport
static var ref: Camera_Battle_SV_Opponent
func _init() -> void:
	ref = self

func _my_pawn() -> ActionPawn:
	return %ActionPawn_CharacterBody2D
