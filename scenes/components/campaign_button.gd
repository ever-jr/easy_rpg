@tool
class_name CampaignButton
extends Button

var id: int = -1

@export var info: BasicInfo:
    get(): return info
    set(value):
        info = value
        _update_text()


func _init(in_id: int = -1, in_info: BasicInfo = null) -> void:
    id = in_id
    info = in_info
    _update_text()


func _enter_tree() -> void:
    _update_text()


func _update_text() -> void:
    if info != null:
        text = info.icon + " " + info.display_name



func _on_button_down() -> void:
    const CAMPAIGN_PAGE_PATH: String = "res://scenes/pages/campaign_page.tscn"
    print("campaign: " + str(id))
    LoggedUser.campaign_id = id
    get_tree().change_scene_to_file(CAMPAIGN_PAGE_PATH)

