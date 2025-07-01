class_name MapData
extends ResourceData

var id: String = generate_scene_unique_id()
@export var visual := VisualData.new()
var id_characters: Array[String] = []

func to_dictionary() -> Dictionary:
	return {
		"visual": visual.to_dictionary(),
		"id_characters": id_characters
	}


static func from_dictionary(data: Dictionary) -> MapData:
	if not data.has("visual"):
		return null
	
	var map := MapData.new()
	
	map.visual = VisualData.from_dictionary(data["visual"])
	
	if data.has("id_characters"):
		for id: String in data["id_characters"]:
			map.id_characters.append(id)
	
	return map
