class_name CampaignData
extends Resource

var id: String = generate_scene_unique_id()
@export var visual := VisualData.new()

@export var player_master: PlayerData = null

@export var players: Array[PlayerData] = []
@export var characters: Array[CharacterData] = []
@export var map := MapData.new()
