extends Node


# PROPERTIES
var _sign_user_data: SignUserData = null
var _player_data := PlayerData.new()

var campaign_id: int = -1


# GETTERS
var email: String:
	get(): return _sign_user_data.email

var access_token: String:
	get(): return _sign_user_data.auth_token

var unique_id: String:
	get(): return _sign_user_data.id

var refresh_token: String:
	get(): return _sign_user_data.refresh_token


# METHODS
func _ready() -> void:
	if Settings.remember_credentials:
		_sign_user_data = SignUserData.load()


func is_logged() -> bool:
	if _sign_user_data == null:
		return false
	else:
		return _sign_user_data.is_valid()


func login(in_sign_user_data: SignUserData) -> void:
	if not is_logged() and in_sign_user_data:
		_sign_user_data = in_sign_user_data

		if Settings.remember_credentials:
			_sign_user_data.save()


func logout() -> void:
	_sign_user_data.free()
	_sign_user_data = null


func clear_saved_credentials() -> void:
	if _sign_user_data:
		_sign_user_data.clear_save()


func is_master(campaign: CampaignData) -> bool:
	if campaign:
		return campaign.player_master.id == unique_id
	
	return false


func get_player_data() -> PlayerData:
	return _player_data
