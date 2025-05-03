extends Node

# PRIVATE PROPERTIES
var _sign_user_data: SignUserData = null

# GETTERS
var email: String:
    get(): return _sign_user_data.email

var access_token: String:
    get(): return _sign_user_data.auth_token

var unique_id: String:
    get(): return _sign_user_data.id


# METHODS
func is_logged() -> bool:
    return _sign_user_data != null

    
func login(in_sign_user_data: SignUserData) -> void:
    if not is_logged():
        _sign_user_data = in_sign_user_data


func logout() -> void:
    _sign_user_data.free()
    _sign_user_data = null
