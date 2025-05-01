extends Node

var email: String = ""
var access_token: String = ""


func is_logged() -> bool:
    return not email.is_empty() and not access_token.is_empty()
    
func login(in_username: String, in_access_token: String) -> void:
    if not is_logged():
        email = in_username
        access_token = in_access_token

func logout() -> void:
    email = ""
    access_token = ""
