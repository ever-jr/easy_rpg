extends Control

const _MIN_COLUMNS: int = 1
const _MIN_ROWS: int = 1

var id: int = -1

@onready var title: Label = %Title
@onready var map_grid: MapGrid = %MapGrid
@onready var pawn_selection: Control = %PawnSelection


func _ready() -> void:
	id = LoggedUser.campaign_id
	Database.fetch_campaigns($HTTPRequest, LoggedUser.access_token)
	pawn_selection.hide()


func _on_http_request_request_completed(_result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	if response_code == 200:
		var campaigns: Array = JSON.parse_string(body.get_string_from_utf8())

		var campaign_data: Dictionary = campaigns[id]
		var basic_info := BasicInfo.find(campaign_data)

		title.text = basic_info.icon + " " + basic_info.display_name


func _on_http_request_property_list_changed() -> void:
	print("property changed!")


func _on_button_settings_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/pages/sheet_setup_page.tscn")


func _on_button_increment_grid_width_button_down() -> void:
	map_grid.columns += 1


func _on_button_decrement_grid_width_button_down() -> void:
	if map_grid.columns <= _MIN_COLUMNS:
		push_warning("min columns limit reached: ({0})".format([_MIN_COLUMNS]))
		return
	
	map_grid.columns -= 1


func _on_button_increment_grid_height_button_down() -> void:
	map_grid.rows += 1


func _on_button_decrement_grid_height_button_down() -> void:
	if map_grid.rows <= _MIN_ROWS:
		push_warning("min rows limit reached: ({0})".format([_MIN_ROWS]))
		return
	
	map_grid.rows -= 1


func _on_map_grid_on_grid_button_pressed(button: MapGridButton) -> void:
	pawn_selection.show()
	pass # Replace with function body.
