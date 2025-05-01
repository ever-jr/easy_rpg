extends Control

@onready var input_username: LineEdit = %Username
@onready var input_password: LineEdit = %Password
@onready var login_request: HTTPRequest = %LoginRequest


func _on_button_login_pressed() -> void:
    var email: String = input_username.text
    var password: String = input_password.text

    print("login in with:\nemail: %s\npassword: %s" % [email, password])
    Database.sign_in(login_request, email, password)
        

func _on_button_sign_in_pressed() -> void:
    var signin_page_path: String = "res://scenes/pages/create_player_page.tscn"
    get_tree().change_scene_to_file(signin_page_path)


func _on_login_request_request_completed(result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
    print("response code: {0} | result: {1}".format(
        [response_code, result]))
    
    var data: String = body.get_string_from_utf8()
    print(data)

