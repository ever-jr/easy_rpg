@tool
class_name Info
extends Node

@export var _data: BasicInfo = null

var icon: String:
	get():
		if _data:
			return _data.icon
		return "❌"

var display_name: String:
	get():
		if _data:
			return _data.display_name
		return "[InvalidInfo]"
