@tool
extends Control

@export var data: SheetData = null

@onready var property_list: HFlowContainer = %PropertyList


func _ready() -> void:
    # add core properties
    for i in range(data.CORE_PROPERTIES.size()):
        var property_data: SheetPropertyData = data.CORE_PROPERTIES[i]

        if property_data == null:
            push_warning("invalid sheet core property({0}) data found on SheetSetupPage's data!".format([i]))
            continue

        var property: SheetProperty = null

        if (property_list.get_child_count() - 1) >= i:
            property = property_list.get_child(i) as SheetProperty
        else:
            property = SheetProperty.create()
            property_list.add_child(property)

        # update data
        if property.data != property_data:
            property.data = property_data

    _update_properties()


func _shortcut_input(event: InputEvent) -> void:
    if event is InputEventKey:
        if event.keycode == KEY_R:
            print("refreshing properties...")
            _update_properties()


func _update_properties() -> void:
    if data == null or property_list == null:
        return
    
    var properties_datas_num: int = data.properties.size()
    var core_properties_datas_num: int = data.CORE_PROPERTIES.size()
    var all_properties_datas_num: int = properties_datas_num + core_properties_datas_num
    var properties_nodes_num: int = property_list.get_child_count()

    # add aditional properties
    for i in range(properties_datas_num):
        var index_with_offset: int = i + core_properties_datas_num

        var property_data: SheetPropertyData = data.properties[i]

        if property_data == null:
            push_warning("invalid sheet property({0}) data found on SheetSetupPage's data!".format([index_with_offset]))
            continue

        var property: SheetProperty = null

        if (properties_nodes_num - 1) >= index_with_offset:
            property = property_list.get_child(index_with_offset) as SheetProperty
        else:
            property = _add_property_node()

        # update data
        if property.data != property_data:
            property.data = property_data

    # update properties nodes amount
    properties_nodes_num = property_list.get_child_count()

    if properties_nodes_num > all_properties_datas_num:
        #print("there still have properties nodes left, excluding...")
        for i in range(all_properties_datas_num, properties_nodes_num):
            var node := property_list.get_child(i) as SheetProperty

            #print("excluding node: [{0}] {1}".format(
            #    [i, node.data.title]
            #))
            _remove_property_node(node)


func _on_property_excluded(node: Node) -> void:
    var property := node as SheetProperty
    if property == null:
        return

    var property_data_index: int = data.properties.find(property.data)

    if property_data_index != -1:
        print("erasing sheet property at: " + str(property_data_index))
        data.properties.remove_at(property_data_index)
        _update_properties()



func _add_property_node() -> SheetProperty:
    var property = SheetProperty.create()

    if not Engine.is_editor_hint():
        var excludable := Excludable.add_or_ignore(property)
        excludable.excluded.connect(_on_property_excluded)

    property_list.add_child(property)

    return property


func _remove_property_node(property: SheetProperty) -> void:
    if property == null:
        return

    for node in property.get_children():
        # clear excludable component's signal
        if node is Excludable:
            node.excluded.disconnect(_on_property_excluded)
            node.queue_free()

    property_list.remove_child(property)
    property.queue_free()


func _on_button_back_button_down() -> void:
    get_tree().change_scene_to_file("res://scenes/pages/campaign_page.tscn")
