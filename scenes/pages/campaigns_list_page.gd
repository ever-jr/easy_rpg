extends Control

signal on_campaign_selected(campaign: CampaignData)

@export var campaigns: Array[CampaignData] = []

@onready var timer: Timer = %Timer
@onready var list_campaigns: VBoxContainer = %ListCampaigns

# NEW CAMPAIGN
@onready var new_campaign_panel: Control = %PanelNewCampaign
@onready var input_campaign_name: LineEdit = %InputCampaignName
@onready var input_campaign_icon: LineEdit = %InputCampaignIcon
@onready var http_request_create_campaign: HTTPRequest = %HTTPRequestCreateCampaign

@onready var http_request_remove_campaign: HTTPRequest = %HTTPRequestRemoveCampaign


func _ready() -> void:
	_update_campaigns()
	fetch_data()


func _on_timer_timeout() -> void:
	#print("updating stats...")
	#print("access token: ", LoggedUser.access_token)
	fetch_data()


func fetch_data() -> void:
	Database.fetch_campaigns($HTTPRequest, LoggedUser.access_token)


func _on_http_request_request_completed(_result:int, response_code:int, _headers:PackedStringArray, body:PackedByteArray) -> void:
	timer.start()
	campaigns.clear()
	if response_code == 200:
		campaigns = DatabaseParser.to_campaigns(body)
		_update_campaigns()


func _update_campaigns() -> void:
	for node in list_campaigns.get_children():
		if node is CampaignButton:
			if node.button_selected.is_connected(_on_campaign_id_selected):
				node.button_selected.disconnect(_on_campaign_id_selected)
			
			if node.exclude_pressed.is_connected(_on_campaign_id_excluded):
				node.exclude_pressed.disconnect(_on_campaign_id_excluded)
		node.queue_free()

	for i in range(campaigns.size()):
		var campaign: CampaignData = campaigns[i]
		var button := CampaignButton.create()
		button.id = i
		button.visual = campaign.visual
		if LoggedUser.is_master(campaign):
			pass
		button.button_selected.connect(_on_campaign_id_selected)
		button.exclude_pressed.connect(_on_campaign_id_excluded)

		list_campaigns.add_child(button)


func _on_campaign_id_selected(campaign_id: int) -> void:
	print(campaign_id)
	on_campaign_selected.emit(campaigns[campaign_id])

func _on_campaign_id_excluded(campaign_id: int) -> void:
	var campaign: CampaignData = campaigns[campaign_id]
	if campaign:
		Database.remove_campaign(http_request_remove_campaign, campaign)
		campaigns.remove_at(campaign_id)
		_update_campaigns()


func _on_button_new_campaign_button_down() -> void:
	new_campaign_panel.show()


func _on_button_cancel_new_campaign_button_down() -> void:
	new_campaign_panel.hide()


func _on_button_create_new_campaign_button_down() -> void:
	var new_campaign := CampaignData.new()
	new_campaign.visual.display_name = input_campaign_name.text
	new_campaign.visual.icon = input_campaign_icon.text
	new_campaign.player_master = LoggedUser.get_player_data()
	Database.register_campaign(http_request_create_campaign, new_campaign)


func _on_http_request_create_campaign_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	var data = JSON.parse_string(body.get_string_from_utf8())
	if data is Dictionary:
		var new_campaign := CampaignData.from_dictionary(data)
		if new_campaign:
			campaigns.append(new_campaign)
			_update_campaigns()


func _on_http_request_remove_campaign_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	pass
