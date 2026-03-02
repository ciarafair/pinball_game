extends Node
var canShoot: bool = true

var selectedTileType: Tile.TileType = Tile.TileType.EMPTY
var selectedTileTrigger: Dictionary = {
	"TOP": false,
	"BOTTOM": false,
	"LEFT": false,
	"RIGHT": false
	}

var spawner: Node2D = null
var fireballScene: Resource = preload("res://scenes/fireball.tscn")

func shoot_timer() -> void:
	await get_tree().create_timer(0.25).timeout
	canShoot = true
	#print_debug("You can shoot again.")
	return

func create_fireball(spawner: Node2D) -> void:
	print_debug("Creating fireball...")
	if canShoot == true: 
		var fireballInstance = fireballScene.instantiate()
		fireballInstance.dir = spawner.global_rotation - 1.5708 # 90 degrees in radians
		fireballInstance.pos = spawner.global_position
		fireballInstance.rota = spawner.global_rotation
		spawner.add_child(fireballInstance)
		canShoot = false
		shoot_timer()
