extends Control


@onready var label_stats: Label = %LabelStats


func _on_timer_timeout() -> void:
    print("updating stats...")
    print("access token: ", LoggedUser.access_token)
