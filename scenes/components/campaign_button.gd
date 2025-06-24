class_name CampaignButton
extends Button

signal button_selected(id: int)

var id: int = -1

@export var visual := VisualData.new():
	get(): return visual
	set(value):
		visual = value
		_update_text()


func _enter_tree() -> void:
	_update_text()


func _update_text() -> void:
	if visual != null:
		text = visual.icon + " " + visual.display_name
	else:
		text = "..."



func _on_button_down() -> void:
	print("campaign: " + visual.display_name)
	button_selected.emit(id)
