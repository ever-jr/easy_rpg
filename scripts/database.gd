extends Node

# URLs
const DATABASE_URL_ROOT: String = "https://easy-rpg-ever-default-rtdb.firebaseio.com"
const DATABASE_URL_PLAYERS: String = DATABASE_URL_ROOT + "/players"

const DATABASE_URL_SIGN_UP_WITHOUT_KEY: String = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key="
const DATABASE_URL_SIGN_IN_WITHOUT_KEY: String = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key="

# KEYS
var database_api_key: String = ""
    

func _ready() -> void:
    # Load token from config file
    var config := ConfigFile.new()
    var err: Error = config.load("res://config/auth.cfg")

    if err == OK:
        database_api_key = config.get_value("keys", "web_api_key", "")
        print("loaded api token successfuly!")

    else:
        push_warning("failed to load api token.")


## Create an account.
func sign_up(http_request: HTTPRequest, email: String, password: String) -> void:
    var url: String = DATABASE_URL_SIGN_UP_WITHOUT_KEY + database_api_key
    var body := JSON.stringify({
        "email": email,
        "password": password,
        "returnSecureToken": true
    })
    http_request.request(url, [], HTTPClient.METHOD_POST, body)
    

## Log in with account.
func sign_in(http_request: HTTPRequest, email: String, password: String) -> void:
    var url: String = DATABASE_URL_SIGN_IN_WITHOUT_KEY + database_api_key
    var body := JSON.stringify({
        "email": email,
        "password": password,
        "returnSecureToken": true
    })
    http_request.request(url, [], HTTPClient.METHOD_POST, body)
