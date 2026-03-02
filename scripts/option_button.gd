extends OptionButton

func _ready() -> void:
    populate_option_button()

func populate_option_button():
    self.clear()
    for type in Tile.TileType.values():
        var type_name = Tile.TileType.keys()[type]
        self.add_item(type_name, type)