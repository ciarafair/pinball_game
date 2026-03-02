extends Node2D

var minsize_of_tiles: float = 32.0
@export var height: int = 13
@export var width: int = 7
@export var cell_size: Vector2 = Vector2(32, 32)

var is_tilemap_set: bool = false

func _on_area_2d_body_exited(body: Node2D) -> void:
	body.queue_free()
	return

func set_tilemap() -> void:
	var tilemaplayer: TileMapLayer = self.get_node("TileMapLayer")
	if tilemaplayer == null:
		print_debug("Error: TileMapLayer node not found.")
		return
	var dictionary_key: int = 0
	var destructive_effect_added: bool = false
	var point_block_added: bool = false

	for x in width:
		for y in height:
			dictionary_key += 1
			var block_chance = randi() % 91
			var damaged_block_chance = randi() % 91
			var destructive_effect_chance = randi() % 91
			var point_block_chance = randi() % 91

			var tile_effect: String = "None"

			var texture: String = ""
			var tile_position = Vector2i(x, y)
			if block_chance < 65:
				tilemaplayer.set_cell(tile_position, 0, Vector2i(1,6), 0)
				texture = "Block"

				# Effects should be added below.
				if destructive_effect_chance > 85 and not destructive_effect_added:
					tile_effect = "Destructive"
					destructive_effect_added = true

				if point_block_chance > 75 and not point_block_added:
					tile_effect = "Point Block"
					point_block_added = true
			else:
				if damaged_block_chance < 35:
					tilemaplayer.set_cell(tile_position, 0, Vector2i(1,7), 0)
					texture = "Damaged Block"
				else:
					texture = "Hole"

			GameManager.tile_dictionary[str(Vector2(x, y))] = {
				"Type": texture,
				"Number": dictionary_key,
				"Effect": tile_effect
			}
			#print_debug("Tile ", dictionary_key, ": ", GameManager.tile_dictionary[str(dictionary_key)])
	is_tilemap_set = true
	return


func create_grid() -> void:
	var grid_container: GridContainer = self.get_node("GridContainer")
	if grid_container == null:
		print_debug("Error: GridContainer node not found.")
		return
	grid_container.columns = width

	var dictionary_position: Vector2 = Vector2(0, 0)
	for y in height:
		for x in width:
			dictionary_position = Vector2(x, y)
			var tile_scene: Resource = preload("res://scenes/tile.tscn")
			var tileInstance = tile_scene.instantiate()

			tileInstance.dictionary_position = dictionary_position

			var tile_data: Dictionary = GameManager.tile_dictionary.get(str(dictionary_position))
			if tile_data == null:
				print_debug("Error: Tile data not found for position ", dictionary_position)
				continue

			if tile_data["Effect"] == "Destructive":
				tileInstance.tileType = Tile.TileType.DESTRUCTIVE
			if tile_data["Effect"] == "Point Block":
				tileInstance.tileType = Tile.TileType.POINT_BLOCK

			tile_data.set("TileNode", tileInstance)
			#print_debug("Tile ", dictionary_position, ": ", GameManager.tile_dictionary[str(dictionary_position)])
			grid_container.add_child(tileInstance)
	SignalManager.emit_signal("GridComplete")
	return

func _ready() -> void:
	GameManager.tile_dictionary.clear()
	set_tilemap()
	create_grid()

func _process(_delta: float) -> void:
	if is_tilemap_set == false:
		set_tilemap()
