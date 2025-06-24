class_name MapData
extends Resource

var id: String = generate_scene_unique_id()
@export var visual := VisualData.new()
var id_characters: Array[String] = []
