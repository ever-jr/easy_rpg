class_name CharacterData
extends ResourceData

var id: String = generate_scene_unique_id()
var display_name: String = "Name"
var icon: String = "👤"
var player_id: String = ""


func to_dictionary() -> Dictionary:
	return {
		"id": id,
		"display_name": display_name,
		"icon": icon,
		"player_id": player_id
	}


static func from_dictionary(data: Dictionary) -> CharacterData:
	var character := CharacterData.new()
	
	if (not data.has("id")
		or not data.has("display_name")
		or not data.has("icon")
		or not data.has("player_id")):
		return null
	
	character.id = data["id"]
	character.display_name = data["display_name"]
	character.icon = data["icon"]
	character.player_id = data["player_id"]

	return character
