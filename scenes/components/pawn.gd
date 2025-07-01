class_name Pawn
extends Node2D


const _HOLDING_OFFSET := Vector2(0.0, -32.0)

var _icon_default_offset := Vector2.ZERO

var is_button_holding := false:
	get(): return is_button_holding
	set(value):
		if is_button_holding != value:
			is_button_holding = value
			
			if is_button_holding:
				_icon_shadow.show()
				_on_holding_started()
			else:
				_icon.position = _icon_default_offset
				_icon_shadow.hide()
				_on_holding_finished()


@onready var _icon: Label = %Icon
@onready var _icon_shadow: Label = %IconShadow


# ==============================================================================
# PARENT

func _ready() -> void:
	_icon_default_offset = _icon.position

func _physics_process(delta: float) -> void:
	if is_button_holding:
		var mouse_position: Vector2 = get_viewport().get_mouse_position()
		global_position = mouse_position
		_icon.position = _icon_default_offset + _HOLDING_OFFSET


# ==============================================================================
# METHODS
func _on_clicked() -> void:
	print("clicked!")

func _on_holding_started() -> void:
	print("holding started")
	# TODO: implement
	pass

func _on_holding_finished() -> void:
	print("holding finished")
	# TODO: implement
	pass



func _on_holder_hold_completed() -> void:
	is_button_holding = true


func _on_holder_hold_canceled() -> void:
	is_button_holding = false
