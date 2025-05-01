class_name DatabaseParser
extends Node


static func sign_in_response_body_to_user_data(body: PackedByteArray) -> Dictionary:
    var user_data := {}
    var data: Dictionary = JSON.parse_string(body.get_string_from_utf8())

    if data.has("email"):
        user_data.email = data["email"]

    if data.has("idToken"):
        user_data.id = data["idToken"]

    return user_data
