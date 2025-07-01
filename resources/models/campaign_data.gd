class_name CampaignData
extends ResourceData

var id: String = generate_scene_unique_id()
@export var visual := VisualData.new()

@export var player_master := PlayerData.new()

@export var players: Array[PlayerData] = []
@export var characters: Array[CharacterData] = []
@export var map := MapData.new()

func to_dictionary() -> Dictionary:
	var player_master_id: String = ""
	var players_data: Array[Dictionary] = []
	var characters_data: Array[Dictionary] = []
	
	return {
		"visual": visual.to_dictionary(),
		"player_master": player_master.to_dictionary(),
		"players": players_data,
		"characters": characters_data,
		"map": map.to_dictionary()
	}


static func from_dictionary(data: Dictionary) -> CampaignData:
	var campaign := CampaignData.new()
	
	if (not data.has("visual")
		or not data.has("player_master")
		or not data.has("map")):
		return null
	
	campaign.visual = VisualData.from_dictionary(data["visual"])
	campaign.player_master = PlayerData.from_dictionary(data["player_master"])
	campaign.map = MapData.from_dictionary(data["map"])
	
	if data.has("players"):
		for player_data_raw: Dictionary in data["players"]:
			var player_data := PlayerData.from_dictionary(player_data_raw)
			if player_data:
				campaign.players.append(player_data)
	
	if data.has("characters"):
		for character_data_raw: Dictionary in data["characters"]:
			var character_data := CharacterData.from_dictionary(character_data_raw)
			if character_data:
				campaign.characters.append(character_data)
	
	return campaign
