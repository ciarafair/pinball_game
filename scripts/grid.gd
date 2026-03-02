@tool
extends Node2D

var minsize_of_tiles: float = 32.0
@export var height: int = 13
@export var width: int = 7
@export var cell_size: Vector2 = Vector2(32, 32)

var tile_dictionary: Dictionary = {}
var is_tilemap_set: bool = false

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

func set_tilemap() -> void:
	var tilemaplayer: TileMapLayer = self.get_node("TileMapLayer")
	if tilemaplayer == null:
		print_debug("Error: TileMapLayer node not found.")
		return
	for x in width:
		for y in height:
			var random_number1 = randi() % 100
			var random_number2 = randi() % 100
			var texture: String = ""
			if random_number1 < 65:
				tilemaplayer.set_cell(Vector2(x, y), 0, Vector2i(1,6), 0)
				texture = "Block"
			else:
				if random_number2 < 35:
					tilemaplayer.set_cell(Vector2(x, y), 0, Vector2i(1,7), 0)
					texture = "Damaged Block"
				else:
					texture = "Empty"
			tile_dictionary[str(Vector2(x, y))] = {
				"Type": texture,
			}
			#print_debug(tile_dictionary)
	is_tilemap_set = true
	return

func _ready() -> void:
	create_grid()

func _process(_delta: float) -> void:
	if is_tilemap_set == false:
		set_tilemap()
