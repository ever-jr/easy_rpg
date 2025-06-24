class_name SignUserData
extends Resource

const _SAVE_PATH: String = "user://saved_credentials.tres"

## User's unique ID.
@export var id: String = ""

## Token for authentication.
@export var auth_token: String = ""

## Token for authentication.
@export var refresh_token: String = ""


func _init(in_id: String = "", in_auth_token: String = "", in_refresh_token: String = "") -> void:
	id = in_id
	auth_token = in_auth_token
	refresh_token = in_refresh_token


func is_valid() -> bool:
	return (not id.is_empty()
		and not auth_token.is_empty()
		and not refresh_token.is_empty()
		)


func save() -> void:
	ResourceSaver.save(self, _SAVE_PATH)


static func load() -> SignUserData:
	if ResourceLoader.exists(_SAVE_PATH):
		return load(_SAVE_PATH)

	return null

func clear_save() -> void:
	if FileAccess.file_exists(_SAVE_PATH):
		DirAccess.remove_absolute(_SAVE_PATH)
		print("sign user saved data erased!")
