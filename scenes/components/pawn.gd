class_name Pawn
extends Node2D

var is_button_pressed := false:
	get(): return is_button_pressed
	set(value):
		if is_button_pressed != value and is_mouse_inside_area:
			is_button_pressed = value
			if is_button_pressed:
				if _hold_timer.is_stopped():
					_hold_timer.start()
			else:
				is_button_holding = false
				if not _hold_timer.is_stopped():
					_hold_timer.stop()
					_on_clicked()
			_update_mouse_cursor()
		else:
			is_button_pressed = false
			is_button_holding = false
			if not _hold_timer.is_stopped():
				_hold_timer.stop()
			_update_mouse_cursor()

var is_button_holding := false:
	get(): return is_button_holding
	set(value):
		if is_button_holding != value and is_mouse_inside_area:
			is_button_holding = value
			if is_button_holding:
				_on_holding_started()
			else:
				_on_holding_finished()
			_update_mouse_cursor()
		else:
			is_button_holding = false
			_update_mouse_cursor()

var is_mouse_inside_area := false:
	get(): return is_mouse_inside_area
	set(value):
		if is_mouse_inside_area != value:
			is_mouse_inside_area = value
			_update_mouse_cursor()

@onready var area: Area2D = %Area2D
@onready var _hold_timer: Timer = %HoldTimer

# ==============================================================================
# PARENT
func _physics_process(delta: float) -> void:
	if is_button_holding:
		var mouse_position: Vector2 = get_viewport().get_mouse_position()
		global_position = mouse_position


# ==============================================================================
# AREA
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		is_button_pressed = event.pressed

func _on_area_2d_mouse_exited() -> void:
	is_mouse_inside_area = false

func _on_area_2d_mouse_entered() -> void:
	is_mouse_inside_area = true

# ==============================================================================
# TIMER
func _on_hold_timer_timeout() -> void:
	var local_mouse_position: Vector2 = area.get_local_mouse_position()
	if is_button_pressed:
		is_button_holding = true

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

func _update_mouse_cursor() -> void:
	if is_button_holding:
		Input.set_default_cursor_shape(Input.CURSOR_DRAG)
	elif is_mouse_inside_area:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	else:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
