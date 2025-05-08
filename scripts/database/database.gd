extends Node

# URLs
const _DATABASE_URL_ROOT: String = "https://easy-rpg-ever-default-rtdb.firebaseio.com"
const _DATABASE_URL_PLAYERS: String = _DATABASE_URL_ROOT + "/players"

const _URL_SIGN_UP_WITHOUT_KEY: String = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key="
const _URL_SIGN_IN_WITHOUT_KEY: String = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key="
const _URL_SIGN_IN_WITH_TOKEN_WITHOUT_KEY: String = "https://securetoken.googleapis.com/v1/token?key="

# KEYS
var _database_api_key: String = ""
    

func _ready() -> void:
    # Load token from config file
    var config := ConfigFile.new()
    var err: Error = config.load("res://config/auth.cfg")

    if err == OK:
        _database_api_key = config.get_value("keys", "web_api_key", "")
        print("loaded api token successfuly!")

    else:
        push_warning("failed to load api token.")


## Create an account.
func sign_up(http_request: HTTPRequest, email: String, password: String) -> void:
    var url: String = _URL_SIGN_UP_WITHOUT_KEY + _database_api_key
    var body := JSON.stringify({
        "email": email,
        "password": password,
        "returnSecureToken": true
    })
    http_request.request(url, [], HTTPClient.METHOD_POST, body)
    

## Log in with account.
func sign_in(http_request: HTTPRequest, email: String, password: String) -> void:
    var url: String = _URL_SIGN_IN_WITHOUT_KEY + _database_api_key
    var body := JSON.stringify({
        "email": email,
        "password": password,
        "returnSecureToken": true
    })
    http_request.request(url, [], HTTPClient.METHOD_POST, body)


func sign_in_with_token(http_request: HTTPRequest, id_token: String) -> void:
    var url: String = _URL_SIGN_IN_WITH_TOKEN_WITHOUT_KEY + _database_api_key
    var body: String = "grant_type=refresh_token&refresh_token="+id_token
    var headers: PackedStringArray = ["Content-Type: application/x-www-form-urlencoded"]
    print(body)
    http_request.request(url, headers, HTTPClient.METHOD_POST, body)


func fetch_campaigns(http_request: HTTPRequest, access_token: String) -> void:
    var url: String = _DATABASE_URL_ROOT + "/campaigns.json"
    http_request.request(url, [], HTTPClient.METHOD_GET)