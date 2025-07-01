class_name PlayerData
extends ResourceData

const INVALID_PLAYER_USERNAME: String = "INVALID_USERNAME"

var id: String = generate_scene_unique_id()
var visual_data := VisualData.new()
var username: String = INVALID_PLAYER_USERNAME

var character_id: String = ""


func _to_string() -> String:
	return "["+id+"] " + visual_data.display_name


func to_dictionary() -> Dictionary:
	return {
		"id": id,
		"visual": visual_data.to_dictionary(),
		"username": username,
		"character_id": character_id
	}

static func from_dictionary(data: Dictionary) -> PlayerData:
	var player := PlayerData.new()
	
	if (not data.has("id")
		or not data.has("visual")
		or not data.has("username")
		or not data.has("character_id")):
		return null
	
	player.id = data["id"]
	player.visual_data = VisualData.from_dictionary(data["visual"])
	player.username = data["username"]
	player.character_id = data["character_id"]
	
	return player
