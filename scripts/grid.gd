extends Node2D

var minsize_of_tiles: float = 32.0
@export var height: int = 13
@export var width: int = 7
@export var cell_size: Vector2 = Vector2(32, 32)

func _on_area_2d_body_exited(body: Node2D) -> void:
	body.queue_free()
	return

func create_grid() -> void:
	var grid_container: GridContainer = self.get_node("GridContainer")
	if grid_container == null:
		print_debug("Error: GridContainer node not found.")
		return
	grid_container.columns = width

	for i in width * height:
		var tile_scene: Resource = preload("res://scenes/tile.tscn")
		var tileInstance = tile_scene.instantiate()
		grid_container.add_child(tileInstance.duplicate())


func _ready() -> void:
	create_grid()
