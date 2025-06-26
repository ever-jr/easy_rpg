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

var is_input_inside_area := false

var is_input_pressed := false:
	get(): return is_input_pressed
	set(value):
		if is_input_pressed != value:
			is_input_pressed = value
			
			if not is_input_pressed:
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


func _on_area_mouse_exited() -> void:
	is_input_inside_area = false
	is_input_pressed = false
	print("leaved")

func _on_area_mouse_entered() -> void:
	is_input_inside_area = true
	print("entered")


func _area_connect_events(area: Area2D) -> void:
	if area:
		if not area.input_event.is_connected(_on_area_input_event):
			area.input_event.connect(_on_area_input_event)
		
		if not area.area_entered.is_connected(_on_area_mouse_entered):
			area.area_entered.connect(_on_area_mouse_entered)
		
		if not area.area_exited.is_connected(_on_area_mouse_exited):
			area.area_exited.connect(_on_area_mouse_exited)

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

func _on_progress_completed() -> void:
	_progress.value = 0.0
	set_progress_enabled(false)
