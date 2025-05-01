@tool
extends Button


@export var info: BasicInfo:
    get: return info
    set(value):
        info = value
        _update_info()


func _process(delta: float) -> void:
    _update_info()

func _update_info():
    var label_icon: Label = %LabelIcon
    
    if info:
        label_icon.text = info.icon
    else:
        var default_info := BasicInfo.new()
        label_icon.text = default_info.icon
