class_name PawnSelectionList
extends ItemList


@export var _list: Array[BasicInfo] = []


func _ready() -> void:
	clear()
	for pawn_info: BasicInfo in _list:
		add_item(_pawn_info_to_string(pawn_info))
	
	item_clicked.connect(_on_item_clicked)


func _on_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	print("item clicked: ", index)


func add_pawn(pawn_info: BasicInfo) -> void:
	if pawn_info == null:
		push_warning("trying to add invalid pawn info to list.")
		return
	
	_list.append(pawn_info)
	add_item(_pawn_info_to_string(pawn_info))

func _pawn_info_to_string(pawn_info: BasicInfo) -> String:
	if pawn_info == null:
		return "INVALID PAWN INFO"
	
	return pawn_info.icon + " - " + pawn_info.display_name
