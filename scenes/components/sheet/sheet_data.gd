class_name SheetData
extends Resource


const CORE_PROPERTIES: Array[SheetPropertyData] = [
    preload("res://resources/sheet/sheet_property_data_icon.tres"),
    preload("res://resources/sheet/sheet_property_data_name.tres")
]

@export var properties: Array[SheetPropertyData] = []