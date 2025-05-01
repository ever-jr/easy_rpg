class_name CreatePlayerPage
extends Control


var error_message_username: String = ""
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
@onready var input_username: LineEdit = %Username
@onready var input_password: LineEdit = %Password
@onready var input_password_confirmation: LineEdit = %PasswordConfirmation
@onready var text_message: RichTextLabel = %Message


# PARENT METHODS
func _ready() -> void:
    update_message()
    

# PRIVATE METHODS
func _on_username_text_changed(new_text: String) -> void:
    error_message_username = verify_username(new_text)
    update_message()
    
    
func _on_password_text_changed(new_text: String) -> void:
    error_message_password = verify_password(new_text)
    update_message()


func _on_password_confirmation_text_changed(new_text: String) -> void:
    error_message_password = verify_password(input_password.text)
    update_message()



func _on_sign_in_pressed() -> void:
    if is_waiting_for_response:
        print("is waiting for request!")
        message_response += "Is waiting for request.\n"
        update_message()
        return
        
    var username: String = input_username.text
    var password: String = input_password.text
    var username_is_valid := false
    var password_is_valid := false
    
    error_message_username = verify_username(username)
    error_message_password = verify_password(password)
    
    username_is_valid = error_message_username.is_empty()
    password_is_valid = error_message_password.is_empty()
    
    if not username_is_valid or not password_is_valid:
        print("invalid player credentials.")
        update_message()
        return
        
    if Database.player_exits(username):
        print("This username already exists on database")
        error_message_username += "- Username [b]already exists[/b] on database.\n"
        update_message()
        return

    print("creating player...")
    is_waiting_for_response = true
    Database.sign_up($HTTPRequestPlayers, username, password)

    update_message()
    

func _on_http_request_players_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
    is_waiting_for_response = false
    print("response code: {response_code} | result: {result}".format({
        "response_code": response_code, "result": result
        }))
    
    if response_code == 200:
        var data: Dictionary = JSON.parse_string(body.get_string_from_utf8())
        print(data)


func _on_log_in_pressed() -> void:
    var login_page_path: String = "res://scenes/pages/login_page.tscn"
    get_tree().change_scene_to_file(login_page_path)


# PUBLIC METHODS
func verify_username(username: String) -> String:
    var error_message: String = ""
    
    if username.is_empty():
        error_message += "- Username can't be [b]empty[/b].\n"
        
    else:
        if username.contains(" "):
            error_message = "- Username can't have [b]empty spaces[/b].\n"
        
    return error_message
    
    
func verify_password(password: String) -> String:
    var error_message: String = ""
    var min_password_length: int = 3
    
    if password.is_empty():
        error_message += "- Password can't be [b]empty[/b].\n"
        
    else:  
        if password.contains(" "):
            error_message += "- Password can't have [b]empty spaces[/b].\n"
            
        if password.length() < min_password_length:
            error_message += "- Password can't be less than [b]"+str(min_password_length)+"[/b].\n"
            
        if password != input_password_confirmation.text:
            error_message += "- Password doesn't match with confirmation password.\n"
    
    return error_message


func update_message() -> void:
    text_message.text = error_message_username + error_message_password + message_response
