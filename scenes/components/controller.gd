class_name Controller
extends Node

# CONSTANTS
const INVALID_CONTROLLER_ID: int = -1

# PROPERTIES
var player_id: int = INVALID_CONTROLLER_ID

# PARENT METHODS
func _init(player_id: int = INVALID_CONTROLLER_ID):
    player_id = player_id
    
# METHODS
func is_valid() -> bool:
    return player_id != INVALID_CONTROLLER_ID
    
# STATIC METHODS
static func has_controller(node: Node) -> bool:
    for child in node.get_children(true):
        if child is Controller:
            return true
    
    return false
