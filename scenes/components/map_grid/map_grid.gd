@tool
class_name MapGrid
extends PanelContainer

signal on_grid_button_pressed(button: MapGridButton)

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
	
	if not Engine.is_editor_hint():
		for node: Node in grid.get_children():
			if node is  MapGridButton:
				if not node.on_pressed.is_connected(_on_grid_button_pressed):
					node.on_pressed.connect(_on_grid_button_pressed.bind(node))


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
			
			if not Engine.is_editor_hint():
				new_button.on_pressed.connect(_on_grid_button_pressed.bind(new_button))
			
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
			
			if not Engine.is_editor_hint():
				if node is MapGridButton:
					node.on_pressed.disconnect(_on_grid_button_pressed)
			
			node.queue_free()
	
	for node: Node in grid.get_children():
		pass


func _on_grid_button_pressed(button: MapGridButton) -> void:
	print(button.name)
	on_grid_button_pressed.emit(button)
