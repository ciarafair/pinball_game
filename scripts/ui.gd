extends Control

func _on_fire_button_pressed() -> void:
	var spawner: Node2D = null
	if spawner == null:
		spawner = self.get_node("/root/LevelRoot/Spawner") as Node2D
	if spawner == null:
		print_debug("Error: Spawner node not found.")
		return
	GameManager.create_fireball(spawner)
	return

func _on_option_button_item_selected(index: int) -> void:
	GameManager.selectedTileType = index as Tile.TileType
