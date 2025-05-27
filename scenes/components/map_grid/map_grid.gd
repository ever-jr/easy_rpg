@tool
class_name MapGrid
extends PanelContainer

@export var columns: int = 3:
	get(): return columns
	set(value):
		if columns != value:
			columns = value
			_update_grid()

@export var rows: int = 3:
	get(): return rows
	set(value):
		if rows != value:
			rows = value
			_update_grid()


@onready var grid: GridContainer = %GridContainer


func _ready() -> void:
	_update_grid()


func _update_grid() -> void:
	if grid == null:
		return

	grid.columns = columns

	var needed_nodes: int = columns * rows
	var current_nodes: int = grid.get_child_count()

	# create missing nodes
	if current_nodes < needed_nodes:
		var missing_nodes: int = needed_nodes - current_nodes
		print("missing children: ", missing_nodes)

		for i in range(current_nodes, current_nodes + missing_nodes):
			var new_button := MapGridButton.create()
			grid.add_child(new_button)

	# delete exceeding nodes
	elif current_nodes > needed_nodes:
		var exceeding_nodes: int = current_nodes - needed_nodes
		print("exceeding children: ", exceeding_nodes)

		for i in range(current_nodes - exceeding_nodes, current_nodes):
			var node: Node = grid.get_child(i)

			if node == null:
				print("node {0} is invalid".format([i]))
				continue

			node.queue_free()
	
	for node: Node in grid.get_children():
		pass
