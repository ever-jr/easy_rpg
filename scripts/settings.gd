extends Node


# FILE
const SETTINGS_FILE_PATH: String = "user://settings.cfg"

var _config_file: ConfigFile = null


# SECTIONS
const _SECTION_LOGIN: String = "login"

var remember_credentials: bool:
    get():
        if _config_file == null:
            return false
        else:
            return _config_file.get_value(_SECTION_LOGIN, "remember_credentials", false)

    set(value):
        if _config_file == null:
            push_warning("settings config_file is invalid, can't set 'remember credentials' property!")
        else:
            _config_file.set_value(_SECTION_LOGIN, "remember_credentials", value)
            save()
        
        if not value:
            LoggedUser.clear_saved_credentials()


func _ready() -> void:
    _config_file = ConfigFile.new()

    var err: int = _config_file.load(SETTINGS_FILE_PATH)
    if err == OK:
        print("loaded settings!")

    else:
        print("failed to load settings _config_file, creating a new one...")

        _config_file.set_value(_SECTION_LOGIN, "remember_credentials", false)

        save()



func save() -> void:
    _config_file.save(SETTINGS_FILE_PATH)