class_name CampaignButton
extends Control

const _RESOURCE := preload("res://scenes/components/campaign_button.tscn")

signal button_selected(id: int)
signal exclude_pressed(id: int)

var id: int = -1

@export var visual := VisualData.new():
	get(): return visual
	set(value):
		visual = value
		_update_text()


@onready var button: Button = %Button
@onready var button_exclude: Button = %ButtonExclude


func _ready() -> void:
	#button.button_down.connect(_on_button_down)
	#button_exclude.button_down.connect(_on_button_exclude_down)
	_update_text()


func _update_text() -> void:
	if not button: return
	
	if visual != null:
		button.text = visual.icon + " " + visual.display_name
	else:
		button.text = "..."



func _on_button_down() -> void:
	print("selecting campaign: " + visual.display_name)
	button_selected.emit(id)


func _on_button_exclude_down() -> void:
	print("excluding campaing: " + visual.display_name)
	exclude_pressed.emit(id)


static func create() -> CampaignButton:
	return _RESOURCE.instantiate()
