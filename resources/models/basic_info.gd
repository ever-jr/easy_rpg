class_name BasicInfo
extends Resource

const DEFAULT_DISPLAY_NAME: String = "[EmptyName]"
const DEFAULT_ICON: String = "👤"

@export var display_name: String = DEFAULT_DISPLAY_NAME
@export var icon: String = DEFAULT_ICON


static func find(data: Dictionary) -> BasicInfo:
	if not data.has("info") or data is not Dictionary:
		print("data do not has info!")
		return null

	var info: Dictionary = data["info"]
	var found_display_name: String = DEFAULT_DISPLAY_NAME
	var found_icon: String = DEFAULT_ICON

	const DISPLAY_NAME_KEY: String = "display_name"
	if not info.has(DISPLAY_NAME_KEY) or info[DISPLAY_NAME_KEY] is not String:
		push_warning("data has 'info' but not have '{0}' as property.".format([DISPLAY_NAME_KEY]))
	else:
		found_display_name = info[DISPLAY_NAME_KEY]

	const ICON_KEY: String = "icon"
	if not info.has(ICON_KEY) or info[ICON_KEY] is not String:
		push_warning("data has 'info' but not have '{0}' as property.".format([ICON_KEY]))
	else:
		found_icon = info[ICON_KEY]

	return BasicInfo.new(found_display_name, found_icon)


func _init(in_display_name: String = DEFAULT_DISPLAY_NAME, in_icon: String = DEFAULT_ICON) -> void:
	display_name = in_display_name
	icon = in_icon
