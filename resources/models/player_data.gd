class_name PlayerData
extends Resource

const INVALID_PLAYER_USERNAME: String = "INVALID_USERNAME"

var username: String = INVALID_PLAYER_USERNAME

var info: BasicInfo = null
var character_id: int = -1

func _init(in_username: String, in_info: BasicInfo, in_character_id: int = -1) -> void:
    username = in_username
    info = in_info
    character_id = in_character_id


func _to_string() -> String:
    return "["+str(info.id)+"] " + info.display_name
