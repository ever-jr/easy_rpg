class_name SignUserData
extends Resource


@export var email: String = ""

## User's unique ID.
@export var id: String = ""

## Token for authentication.
@export var auth_token: String = ""


func _init(in_email: String, in_id: String, in_auth_token: String) -> void:
    email = in_email
    id = in_id
    auth_token = in_auth_token


func is_valid() -> bool:
    return (not email.is_empty()
        and not id.is_empty()
        and not auth_token.is_empty())