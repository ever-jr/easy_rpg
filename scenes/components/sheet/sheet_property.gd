@tool
class_name SheetProperty
extends PanelContainer


const _RESOURCE: PackedScene = preload("res://scenes/components/sheet/sheet_property.tscn")

const _SHEET_INPUT_THEME_SMALL_RESOURCE_PATH: String = "res://resources/sheet/sheet_property_input_small.tres"
const _SHEET_INPUT_THEME_MEDIUM_RESOURCE_PATH: String = "res://resources/sheet/sheet_property_input_medium.tres"
const _SHEET_INPUT_THEME_BIG_RESOURCE_PATH: String = "res://resources/sheet/sheet_property_input_big.tres"

@onready var label: Label = %Title
@onready var input: LineEdit = %Input

@export var data: SheetPropertyData:
    get(): return data
    set(value):
        data = value
        print("sheet property changed!")
        _update_properties()


func _ready() -> void:
    _update_properties()


func _update_properties() -> void:
    if (data == null
        or label == null
        or input == null):
        return
    
    label.text = data.title
    input.text = data.value

    var input_theme_path: String = _SHEET_INPUT_THEME_MEDIUM_RESOURCE_PATH

    if data.size == SheetPropertyData.SheetPropertySize.small:
        input_theme_path = _SHEET_INPUT_THEME_SMALL_RESOURCE_PATH

    elif data.size == SheetPropertyData.SheetPropertySize.big:
        input_theme_path = _SHEET_INPUT_THEME_BIG_RESOURCE_PATH
    
    var input_theme: Theme = load(input_theme_path)

    if input_theme == null:
        push_warning("invalid Input Them on SheetProperty!")
    else:
        input.theme = input_theme


static func create() -> SheetProperty:
    return _RESOURCE.instantiate()
