class_name Holder
extends Node2D

signal hold_canceled()
signal hold_completed()

@export var area: Area2D
@export var holding_time: float = 0.5:
	get(): return holding_time
	set(value):
		if value > 0.0:
			holding_time = value

var is_inside_area := false:
	get(): return is_inside_area
	set(value):
		if is_inside_area != value:
			is_inside_area = value
			
			if is_inside_area:
				Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
			else:
				Input.set_default_cursor_shape(Input.CURSOR_ARROW)


var is_holding := false:
	get(): return is_holding
	set(value):
		if is_holding != value:
			is_holding = value
			if is_holding:
				Input.set_default_cursor_shape(Input.CURSOR_DRAG)
			else:
				Input.set_default_cursor_shape(Input.CURSOR_ARROW)

var is_input_pressed := false:
	get(): return is_input_pressed
	set(value):
		if is_input_pressed != value:
			is_input_pressed = value
			
			if not is_input_pressed:
				is_holding = false
				hold_canceled.emit()
			
			if _progress.value != _progress.max_value:
				set_progress_enabled(true)


@onready var _timer: Timer = %Timer
@onready var _progress: ProgressBar = %ProgressBar


func _ready() -> void:
	_area_connect_events(area)
	set_progress_enabled(false)


func _physics_process(delta: float) -> void:
	var increment: float = 1/holding_time * delta
	if is_input_pressed:
		_progress.value += increment
		if _progress.value >= _progress.max_value:
			_on_progress_completed()
		
	else:
		_progress.value -= increment
		if _progress.value <= 0.0:
			_on_progress_reseted()

# ==============================================================================
# AREA
func _on_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		is_input_pressed = event.pressed


func _on_area_mouse_entered() -> void:
	is_inside_area = true


func _on_area_mouse_exited() -> void:
	is_inside_area = false
	if is_input_pressed and not is_holding:
		is_input_pressed = false


func _area_connect_events(area: Area2D) -> void:
	if area:
		if not area.input_event.is_connected(_on_area_input_event):
			area.input_event.connect(_on_area_input_event)
		
		if not area.mouse_entered.is_connected(_on_area_mouse_entered):
			area.mouse_entered.connect(_on_area_mouse_entered)
		
		if not area.mouse_exited.is_connected(_on_area_mouse_exited):
			area.mouse_exited.connect(_on_area_mouse_exited)


func _area_disconnect_events(area: Area2D) -> void:
	if area:
		if area.area_entered.is_connected(_on_area_mouse_entered):
			area.area_entered.disconnect(_on_area_mouse_entered)
		
		if area.area_exited.is_connected(_on_area_mouse_exited):
			area.area_exited.disconnect(_on_area_mouse_exited)
		
		if area.input_event.is_connected(_on_area_input_event):
			area.input_event.disconnect(_on_area_input_event)

# ==============================================================================
# PROGRESS
func set_progress_enabled(enabled: bool) -> void:
	set_physics_process(enabled)
	if enabled:
		_progress.show()
	else:
		_progress.hide()

func _on_progress_reseted() -> void:
	set_progress_enabled(false)
	hold_canceled.emit()

func _on_progress_completed() -> void:
	is_holding = true
	_progress.value = 0.0
	set_progress_enabled(false)
	hold_completed.emit()
