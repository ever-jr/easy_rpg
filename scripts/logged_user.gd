extends Node

var username: String = ""
var access_token: String = ""


func is_logged() -> bool:
    return username.is_empty() or access_token.is_empty()
    
func login(in_username: String, in_access_token: String) -> void:
    username = in_username
    access_token = in_access_token

func logout() -> void:
    username = ""
    access_token = ""
