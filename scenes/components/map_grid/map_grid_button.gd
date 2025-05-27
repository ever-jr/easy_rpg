@tool
class_name MapGridButton
extends PanelContainer

const _RESOURCE: PackedScene = preload("res://scenes/components/map_grid/map_grid_button.tscn")

@export var target: Info:
	get(): return target
	set(value):
		if value == null:
			button.text = ""
		else:
			button.text = target.icon

		target = value


var button: Button:
	get(): return $Button


func _ready() -> void:
	if target == null:
		button.text = ""
		return
	
	button.text = target.icon



static func create() -> MapGridButton:
	return _RESOURCE.instantiate()
