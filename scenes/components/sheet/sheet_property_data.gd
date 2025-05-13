class_name SheetPropertyData
extends Resource

enum SheetPropertySize { small, medium, big }
enum SheetPropertyType { text, number }

const _DEFAULT_PROPERTY_NAME: String = "[PropertyName]"
const _DEFAULT_PROPERTY_VALUE: String = "[Value]"

@export var title: String = _DEFAULT_PROPERTY_NAME
@export var value: String = _DEFAULT_PROPERTY_VALUE
@export var type := SheetPropertyType.number
@export var size := SheetPropertySize.medium


func _init(
    in_title: String = _DEFAULT_PROPERTY_NAME,
    in_value: String = _DEFAULT_PROPERTY_VALUE,
    in_type := SheetPropertyType.text,
    in_size := SheetPropertySize.medium,
    ) -> void:
    title = in_title
    value = in_value
    type = in_type
    size = in_size