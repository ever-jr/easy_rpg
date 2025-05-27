class_name EasyRPGDataReader
extends Node
	

static func from_json(json_data: JSON) -> EasyRPGData:
	var easy_rpg_data := EasyRPGData.new()
	var data: Dictionary = json_data.data
	
	if not data.has("players"):
		# TODO: turn into in game debug
		print("data doesn't contains 'players' key!")
	else:
		if data["players"] is not Dictionary:
			print("'players' in data is not Dictionary type!")
		else:
			var players: Dictionary = data["players"]
			for player_username in players.keys():
				var player: Dictionary = players.get(player_username)
				
				var new_player_info := BasicInfo.new()
				new_player_info.display_name = player["display_name"]
				new_player_info.icon = player["icon"]
				
				var new_player_data := PlayerData.new(player_username, new_player_info)
				
				easy_rpg_data.players.append(new_player_data)
			
	return easy_rpg_data
