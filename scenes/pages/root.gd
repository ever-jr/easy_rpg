extends Node2D

@export var campaign: CampaignData:
	get(): return campaign
	set(value):
		campaign = value
		if not LoggedUser.is_logged():
			show_page(login_page)
		elif not campaign:
			show_page(campaign_list_page)
		else:
			hide_pages()

@onready var ui: CanvasLayer = %UI
@onready var login_page: Control = %LoginPage
@onready var campaign_list_page: Control = %CampaignListPage
@onready var campaign_page: Control = %CampaignPage


func _ready() -> void:
	if not LoggedUser.is_logged():
		show_page(login_page)
	elif not campaign:
		show_page(campaign_list_page)
	else:
		hide_pages()



func show_page(page_to_show: Control) -> void:
	for page: Node in ui.get_children():
		if page is Control:
			if page == page_to_show:
				page.show()
			else:
				page.hide()

func hide_pages() -> void:
	for page: Node in ui.get_children():
		if page is Control:
			page.hide()

func _on_login_page_logged() -> void:
	print("logged!")


func _on_campaign_list_page_on_campaign_selected(campaign_data: CampaignData) -> void:
	campaign = campaign_data
