class_name Excludable
extends Control

signal excluded(node: Node)

const _RESOURCE: PackedScene = preload("res://scenes/models/excludable.tscn")


static func create() -> Excludable:
    return _RESOURCE.instantiate()


## adds a component to this node or ignores if already has one.
static func add_or_ignore(root_node: Node) -> Excludable:
    for node in root_node.get_children():
        if node is Excludable:
            return node
    
    var new_excludable := Excludable.create()
    root_node.add_child(new_excludable)

    return new_excludable


func _on_button_down() -> void:
    print("{0} excluded!".format([get_parent().name]))
    excluded.emit(get_parent())
