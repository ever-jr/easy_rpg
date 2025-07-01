class_name Spot
extends Node2D


func _on_area_2d_area_entered(area: Area2D) -> void:
	print(area, " entered")


func _on_area_2d_area_exited(area: Area2D) -> void:
	print(area, " exited")
