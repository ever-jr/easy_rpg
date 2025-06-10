extends Control

@onready var input_email: LineEdit = %Email
@onready var input_password: LineEdit = %Password
@onready var button_login: Button = %ButtonLogIn
@onready var button_signin: Button = %ButtonSignIn
@onready var login_request: HTTPRequest = %LoginRequest



func _ready() -> void:
	var remember_credentials: bool = Settings.remember_credentials
	(%CheckBoxRememberCredentials as CheckBox).button_pressed = remember_credentials

	if LoggedUser.is_logged():
		print("already logged, entering...")
		
		set_buttons_enabled(false)
		Database.sign_in_with_token(login_request, LoggedUser.refresh_token)

	elif remember_credentials:
		print("remembering credentials but credentials saved not found.")


func _on_check_box_remember_credentials_toggled(toggled_on: bool) -> void:
	Settings.remember_credentials = toggled_on


func _on_button_login_pressed() -> void:
	var email: String = input_email.text
	var password: String = input_password.text

	print("login in with:\nemail: %s\npassword: %s" % [email, password])
	Database.sign_in(login_request, email, password)
		

func _on_button_sign_in_pressed() -> void:
	var signin_page_path: String = "res://scenes/pages/create_player_page.tscn"
	get_tree().change_scene_to_file(signin_page_path)


func _on_login_request_request_completed(_result: int, response_code: int, _headers: PackedStringArray, body: PackedByteArray) -> void:
	set_buttons_enabled(true)
	print("response code: {0}\nbody: {1}".format(
		[response_code, body.get_string_from_utf8()]))
	
	if response_code == 200:
		var user_data: SignUserData = DatabaseParser.sign_response_body_to_data(body)

		LoggedUser.login(user_data)

		if LoggedUser.is_logged():
			var home_page_path: String = "res://scenes/pages/home_page.tscn"
			get_tree().change_scene_to_file(home_page_path)


	else:
		print("login failed!")


func set_buttons_enabled(enabled: bool) -> void:
	button_login.disabled = not enabled
	button_signin.disabled = not enabled
