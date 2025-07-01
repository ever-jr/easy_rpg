class_name DatabaseParser
extends Node


static func sign_response_body_to_data(body: PackedByteArray) -> SignUserData:
	var data: Dictionary = JSON.parse_string(body.get_string_from_utf8())
	
	if not data.has("idToken"):
		push_warning("sign response has no 'idToken' key")
		return null
	
	if not data.has("localId"):
		push_warning("sign response has no 'localId' key")
		return null
	
	if not data.has("refreshToken"):
		push_warning("sign response has no 'refreshToken' key")
		return null
	
	var id: String = data["localId"]
	var auth_token: String = data["idToken"]
	var refresh_token: String = data["refreshToken"]
	
	return SignUserData.new(id, auth_token, refresh_token)


static func to_campaigns(body: PackedByteArray) -> Array[CampaignData]:
	var data = JSON.parse_string(body.get_string_from_utf8())
	if data is not Dictionary:
		return []
	
	var campaigns: Array[CampaignData] = []
	
	for campaign_id: String in data:
		var campaign_raw: Dictionary = data[campaign_id]
		var campaign := CampaignData.from_dictionary(campaign_raw)
		if campaign:
			campaign.id = campaign_id
			campaigns.append(campaign)
	
	return campaigns
