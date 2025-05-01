extends Control

const MIN_PASSWORD_LENGTH: int = 6

var error_message_email: String = ""
var error_message_password: String = ""
var message_response: String = ""
var is_waiting_for_response := false:
    get: return is_waiting_for_response
    set(value):
        if value != is_waiting_for_response:
            is_waiting_for_response = value
            if value:
                message_response = "...\n"
            else:
                message_response = ""
            
            update_message()

# NODES
@onready var input_email: LineEdit = %Email
@onready var input_password: LineEdit = %Password
@onready var input_password_confirmation: LineEdit = %PasswordConfirmation
@onready var text_message: RichTextLabel = %Message
@onready var http_request: HTTPRequest = %HTTPRequest


# PARENT METHODS
func _ready() -> void:
    update_message()
    

# PRIVATE METHODS
func _on_email_text_changed(new_text: String) -> void:
    error_message_email = verify_email(new_text)
    update_message()
    
    
func _on_password_text_changed(new_text: String) -> void:
    error_message_password = verify_password(new_text)
    update_message()


func _on_password_confirmation_text_changed(_new_text: String) -> void:
    error_message_password = verify_password(input_password.text)
    update_message()



func _on_sign_in_pressed() -> void:
    if is_waiting_for_response:
        print("is waiting for request!")
        message_response += "Is waiting for request.\n"
        update_message()
        return
        
    var username: String = input_email.text
    var password: String = input_password.text
    var username_is_valid := false
    var password_is_valid := false
    
    error_message_email = verify_email(username)
    error_message_password = verify_password(password)
    
    username_is_valid = error_message_email.is_empty()
    password_is_valid = error_message_password.is_empty()
    
    if not username_is_valid or not password_is_valid:
        print("invalid player credentials.")
        update_message()
        return

    print("creating player...")
    is_waiting_for_response = true
    Database.sign_up(http_request, username, password)

    update_message()
    

func _on_http_request_completed(result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
    is_waiting_for_response = false
    print("response code: {response_code} | result: {result}\nbody: {body}".format({
        "response_code": response_code, "result": result, "body": body.get_string_from_utf8(),
        }))

    var data: Dictionary = JSON.parse_string(body.get_string_from_utf8())
    if response_code == 200:
        var user_data: Dictionary = DatabaseParser.sign_in_response_body_to_user_data(body)

        LoggedUser.login(user_data["email"], user_data["id"])
        if LoggedUser.is_logged():
            var home_page_path: String = "res://scenes/pages/home_page.tscn"
            get_tree().change_scene_to_file(home_page_path)

    elif data.has("error") and data["error"].has("message"):
        var error_message: String = data["error"]["message"]

        if error_message == "EMAIL_EXISTS":
            message_response = "Email already exists!"

        else:
            message_response = error_message

        update_message()


func _on_log_in_pressed() -> void:
    var login_page_path: String = "res://scenes/pages/login_page.tscn"
    get_tree().change_scene_to_file(login_page_path)


# PUBLIC METHODS
func verify_email(username: String) -> String:
    var error_message: String = ""
    
    if username.is_empty():
        error_message += "- Username can't be [b]empty[/b].\n"
        
    else:
        if username.contains(" "):
            error_message = "- Username can't have [b]empty spaces[/b].\n"
        
    return error_message
    
    
func verify_password(password: String) -> String:
    var error_message: String = ""
    
    if password.is_empty():
        error_message += "- Password can't be [b]empty[/b].\n"
        
    else:  
        if password.contains(" "):
            error_message += "- Password can't have [b]empty spaces[/b].\n"
            
        if password.length() < MIN_PASSWORD_LENGTH:
            error_message += "- Password can't be less than [b]"+str(MIN_PASSWORD_LENGTH)+"[/b].\n"
            
        if password != input_password_confirmation.text:
            error_message += "- Password doesn't match with confirmation password.\n"
    
    return error_message


func update_message() -> void:
    text_message.text = error_message_email + error_message_password + message_response
