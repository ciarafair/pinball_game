extends Button

@export var price: int = 0
var is_mouse_over: bool = false
var selected_item_key: String = "" 

var items: Dictionary = {
	"PurchasedTile": {
		"Price": 0,
		"Texture": null,
		"Type": Tile.TileType.EMPTY
	},
	"TopRight": {
		"Price": 5,
		"Texture": preload("res://assets/textures/topright.png"),
		"Type": Tile.TileType.TOPRIGHTCORNER
	},
	"TopLeft": {
		"Price": 10,
		"Texture": preload("res://assets/textures/topleft.png"),
		"Type": Tile.TileType.TOPLEFTCORNER
	},
	"BottomRight": {
		"Price": 15,
		"Texture": preload("res://assets/textures/bottomright.png"),
		"Type": Tile.TileType.BOTTOMRIGHTCORNER
	},
	"BottomLeft": {
		"Price": 20,
		"Texture": preload("res://assets/textures/bottomleft.png"),
		"Type": Tile.TileType.BOTTOMLEFTCORNER
	}
}

func set_price() -> void:
	var price_label = get_node("PriceLabel") as Label
	price_label.text = "$" + str(price)

func set_item(item_key: String) -> void:
	selected_item_key = item_key
	price = items[item_key]["Price"]
	var texture_rect = get_node("TextureRect") as TextureRect
	texture_rect.texture = items[item_key]["Texture"]
	return

func set_random_item() -> void:
	var item_keys = items.keys()
	var random_index = randi() % item_keys.size()
	set_item(item_keys[random_index])
	return

func _ready() -> void:
	set_random_item()
	return

func _process(_delta: float) -> void:
	set_price()
	
func _on_pressed() -> void:
	print_debug("Tile pressed.")
	if GameManager.points < price:
		print_debug("Not enough points to purchase this tile.")
		return
	GameManager.selectedTileType = items[selected_item_key]["Type"]
	GameManager.points -= price
	set_item("PurchasedTile")
	return
