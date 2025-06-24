class_name PlayerData
extends Resource

const INVALID_PLAYER_USERNAME: String = "INVALID_USERNAME"

var id: String = generate_scene_unique_id()
var visual_data := VisualData.new()
var username: String = INVALID_PLAYER_USERNAME

var character_id: String = ""

func _init(in_username: String) -> void:
	username = in_username


func _to_string() -> String:
	return "["+id+"] " + visual_data.display_name
