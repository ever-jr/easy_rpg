extends Control


@export var button_resource: PackedScene

@onready var timer: Timer = %Timer
@onready var list_campaigns: VBoxContainer = %ListCampaigns


func _ready() -> void:
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
        var campaigns: Array = JSON.parse_string(body.get_string_from_utf8())

        for node in list_campaigns.get_children():
            node.free()

        if button_resource == null:
            return
        

        var length: int = campaigns.size()
        for i in range(length):
            var basic_info := BasicInfo.find(campaigns[i])

            if basic_info != null:
                var button: CampaignButton = button_resource.instantiate()
                button.id = i
                button.info = basic_info

                list_campaigns.add_child(button)

        # TODO: make the list reset the names too / clear better
        #list_campaigns.print_tree()
