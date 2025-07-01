class_name VisualData
extends ResourceData

const _DEFAULT_ICON: String = "👤"
const _DEFAULT_NAME: String = "[EmptyName]"

@export var icon: String = _DEFAULT_ICON
@export var display_name: String = _DEFAULT_NAME

func to_dictionary() -> Dictionary:
	return {
		"icon": icon,
		"display_name": display_name
	}

static func from_dictionary(data: Dictionary) -> VisualData:
	var new_visual := VisualData.new()
	
	if (not data.has("icon")
		or not data.has("display_name")):
		return null
	
	new_visual.icon = data["icon"]
	new_visual.display_name = data["display_name"]
	
	return new_visual
