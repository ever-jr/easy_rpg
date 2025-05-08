extends Control

var id: int = -1
@onready var title: Label = %Title


func _ready() -> void:
    id = LoggedUser.campaign_id
    Database.fetch_campaigns($HTTPRequest, LoggedUser.access_token)


func _on_http_request_request_completed(result:int, response_code:int, headers:PackedStringArray, body:PackedByteArray) -> void:
    if response_code == 200:
        var campaigns: Array = JSON.parse_string(body.get_string_from_utf8())

        var campaign_data: Dictionary = campaigns[id]
        var basic_info := BasicInfo.find(campaign_data)

        title.text = basic_info.icon + " " + basic_info.display_name


func _on_http_request_property_list_changed() -> void:
    print("property changed!")
