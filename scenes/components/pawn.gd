class_name Pawn
extends Node2D

var is_button_pressed := false:
	get(): return is_button_pressed
	set(value):
		if is_button_pressed != value:
			is_button_pressed = value
			if is_button_pressed:
				if _hold_timer.is_stopped():
					_hold_timer.start()
			else:
				is_button_holding = false
				if not _hold_timer.is_stopped():
					_hold_timer.stop()
					_on_clicked()

var is_button_holding := false:
	get(): return is_button_holding
	set(value):
		if is_button_holding != value:
			is_button_holding = value
			if is_button_holding:
				_on_holding_started()
			else:
				_on_holding_finished()


@onready var _hold_timer: Timer = %HoldTimer


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		is_button_pressed = event.pressed


func _on_hold_timer_timeout() -> void:
	if is_button_pressed:
		is_button_holding = true


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
