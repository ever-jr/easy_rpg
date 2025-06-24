class_name Campaigns
extends Resource

const _SAVE_PATH: String = "user://campaigns.tres"

@export var list: Array[Campaign] = []

func save() -> void:
	ResourceSaver.save(self, _SAVE_PATH)


static func load() -> Campaigns:
	if ResourceLoader.exists(_SAVE_PATH):
		return load(_SAVE_PATH)

	return new()

func clear_save() -> void:
	if FileAccess.file_exists(_SAVE_PATH):
		DirAccess.remove_absolute(_SAVE_PATH)
		print("campaigns data erased!")
