extends Control

signal on_campaign_selected(campaign: CampaignData)

@export var button_resource: PackedScene
@export var campaigns: Array[CampaignData] = []

@onready var timer: Timer = %Timer
@onready var list_campaigns: VBoxContainer = %ListCampaigns


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

	#print("response:\n- code: {code}\n- data: {data}".format({
	#    "code": response_code,
	#    "data": body.get_string_from_utf8()
	#}))

	if response_code == 200:
		var campaigns_data: Array = JSON.parse_string(body.get_string_from_utf8())

		if button_resource == null:
			return
		
		var length: int = campaigns_data.size()
		for i in range(length):
			var basic_info := BasicInfo.find(campaigns_data[i])
			if basic_info:
				var new_campaign := CampaignData.new()
				new_campaign.visual.display_name = basic_info.display_name
				new_campaign.visual.icon = basic_info.icon
				campaigns.append(new_campaign)
		_update_campaigns()


		# TODO: make the list reset the names too / clear better
		#list_campaigns.print_tree()


func _update_campaigns() -> void:
	for node in list_campaigns.get_children():
		if node is CampaignButton:
			if node.button_selected.is_connected(_on_campaign_id_selected):
				node.button_selected.disconnect(_on_campaign_id_selected)
		node.free()

	for i in range(campaigns.size()):
		var campaign: CampaignData = campaigns[i]
		var button: CampaignButton = button_resource.instantiate()
		button.id = i
		button.visual = campaign.visual
		button.button_selected.connect(_on_campaign_id_selected)

		list_campaigns.add_child(button)


func _on_campaign_id_selected(campaign_id: int) -> void:
	on_campaign_selected.emit(campaigns[campaign_id])
