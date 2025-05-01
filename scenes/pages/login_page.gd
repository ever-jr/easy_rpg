extends Control

@onready var input_email: LineEdit = %Email
@onready var input_password: LineEdit = %Password
@onready var login_request: HTTPRequest = %LoginRequest


func _on_button_login_pressed() -> void:
    var email: String = input_email.text
    var password: String = input_password.text

    print("login in with:\nemail: %s\npassword: %s" % [email, password])
    Database.sign_in(login_request, email, password)
        

func _on_button_sign_in_pressed() -> void:
    var signin_page_path: String = "res://scenes/pages/create_player_page.tscn"
    get_tree().change_scene_to_file(signin_page_path)


func _on_login_request_request_completed(result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
    print("response code: {0} | result: {1}".format(
        [response_code, result]))
    
    if response_code == 200:
        var user_data: Dictionary = DatabaseParser.sign_in_response_body_to_user_data(body)

        print("User data:\nEmail: {email}\nID token: {id}".format({
            "email": user_data.email,
            "id": user_data.id,
        }))

        LoggedUser.login(user_data.email, user_data.id)

        if LoggedUser.is_logged():
            var home_page_path: String = "res://scenes/pages/home_page.tscn"
            get_tree().change_scene_to_file(home_page_path)


    else:
        print("login failed!")
