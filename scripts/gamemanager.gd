extends Node
var canShoot: bool = true

var selectedTileType: Tile.TileType = Tile.TileType.EMPTY
var selectedTileTrigger: Dictionary = {
	"TOP": false,
	"BOTTOM": false,
	"LEFT": false,
	"RIGHT": false
	}

@export var tile_dictionary: Dictionary = {}

var player_inventory: Dictionary = {}

var points: int = 60

var spawner: Node2D = null
var fireballScene: Resource = preload("res://scenes/fireball.tscn")

func shoot_timer() -> void:
	await get_tree().create_timer(0.25).timeout
	canShoot = true
	#print_debug("You can shoot again.")
	return

func create_fireball(node: Node2D) -> void:
	#print_debug("Creating fireball...")
	if canShoot == true: 
		var fireballInstance = fireballScene.instantiate()
		node.add_child(fireballInstance)
		fireballInstance.direction = Vector2(0, -1)
		canShoot = false
		shoot_timer()
