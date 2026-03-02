extends Node
var canShoot: bool = true

var selectedTileType: Tile.TileType = Tile.TileType.EMPTY
var selectedTileTrigger: Dictionary = {
	"TOP": false,
	"BOTTOM": false,
	"LEFT": false,
	"RIGHT": false
	}

var points: int = 0

var spawner: Node2D = null
var fireballScene: Resource = preload("res://scenes/fireball.tscn")

func shoot_timer() -> void:
	await get_tree().create_timer(0.25).timeout
	canShoot = true
	#print_debug("You can shoot again.")
	return

func create_fireball(spawner: Node2D) -> void:
	#print_debug("Creating fireball...")
	if canShoot == true: 
		var fireballInstance = fireballScene.instantiate()
		spawner.add_child(fireballInstance)
		fireballInstance.direction = Vector2(0, -1)
		canShoot = false
		shoot_timer()
