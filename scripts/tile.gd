class_name Tile extends Control

enum TileType {EMPTY, DESTRUCTIVE, TOPLEFTCORNER, TOPRIGHTCORNER, BOTTOMLEFTCORNER, BOTTOMRIGHTCORNER, BOUNCE, TRIGGERTOP, TRIGGERBOTTOM, TRIGGERLEFT, TRIGGERRIGHT, POINT_BLOCK}
var binTexture: Resource = preload("res://assets/textures/bin.png")
var topLeftCornerTexture: Resource = preload("res://assets/textures/topleft.png")
var topRightCornerTexture: Resource = preload("res://assets/textures/topright.png")
var bottomLeftCornerTexture: Resource = preload("res://assets/textures/bottomleft.png")
var bottomRightCornerTexture: Resource = preload("res://assets/textures/bottomright.png")
var bounceTexture: Resource = preload("res://assets/textures/bounce.png")
var triggerTexture: Resource = preload("res://assets/textures/point.png")
var pointBlockTexture: Resource = preload("res://assets/textures/pointblock.png")

var fireballInstance: Fireball = null

@export var isTopTrigger: bool
var topTriggerInstance: Tile = null
@export var isBottomTrigger: bool
var bottomTriggerInstance: Tile = null
@export var isLeftTrigger: bool
var leftTriggerInstance: Tile = null
@export var isRightTrigger: bool
var rightTriggerInstance: Tile = null
@export var tileType: TileType

var dictionary_position: Vector2

func _ready() -> void:
	SignalManager.connect("GridComplete", _on_grid_complete)
	return

func _on_grid_complete() -> void:
	set_texture(self)

	if self.tileType == TileType.POINT_BLOCK:
		generate_points()
	return

func tile_action() -> void:
	if self.fireballInstance == null:
		return
	if self.tileType != TileType.EMPTY:
		if self.tileType == TileType.DESTRUCTIVE:
			#print_debug("Destroying projectile.")
			self.fireballInstance.queue_free()
			self.fireballInstance = null
			return

		if self.tileType == TileType.TOPLEFTCORNER:
			if self.fireballInstance == null:
				return
			if fireballInstance.direction == Vector2(0,-1): # Up
				self.fireballInstance.direction = Vector2(1,0) # Right
			elif fireballInstance.direction == Vector2(-1,0): # Left
				self.fireballInstance.direction = Vector2(0,1) # Down
			elif fireballInstance.direction == Vector2(0,1): # Down
				self.fireballInstance.direction = Vector2(0, -1) # Up
			elif fireballInstance.direction == Vector2(1,0): # Right
				self.fireballInstance.direction = Vector2(-1,0) # Left
			self.fireballInstance = null
			return

		if self.tileType == TileType.TOPRIGHTCORNER:
			if self.fireballInstance == null:
				return
			if fireballInstance.direction == Vector2(0,-1): # Up
				self.fireballInstance.direction = Vector2(-1,0) # Left
			elif fireballInstance.direction == Vector2(1,0): # Right
				self.fireballInstance.direction = Vector2(0,1) # Down
			elif fireballInstance.direction == Vector2(0,1): # Down
				self.fireballInstance.direction = Vector2(0, -1) # Up
			elif fireballInstance.direction == Vector2(-1,0): # Left
				self.fireballInstance.direction = Vector2(1,0) # Right
			self.fireballInstance = null
			return

		if self.tileType == TileType.BOTTOMLEFTCORNER:
			if self.fireballInstance == null:
				return
			if fireballInstance.direction == Vector2(0,1): # Down
				self.fireballInstance.direction = Vector2(1,0) # Right
			elif fireballInstance.direction == Vector2(-1,0): # Left
				self.fireballInstance.direction = Vector2(0,-1) # Up
			elif fireballInstance.direction == Vector2(0,-1): # Up
				self.fireballInstance.direction = Vector2(0,1) # Down
			elif fireballInstance.direction == Vector2(1,0): # Right
				self.fireballInstance.direction = Vector2(-1,0) # Left
			self.fireballInstance = null
			return

		if self.tileType == TileType.BOTTOMRIGHTCORNER:
			if self.fireballInstance == null:
				return
			if fireballInstance.direction == Vector2(0,1): # Down
				self.fireballInstance.direction = Vector2(-1,0) # Left
			elif fireballInstance.direction == Vector2(1,0): # Right
				self.fireballInstance.direction = Vector2(0,-1) # Up
			elif fireballInstance.direction == Vector2(0,-1): # Up
				self.fireballInstance.direction = Vector2(0,1) # Down
			elif fireballInstance.direction == Vector2(-1,0): # Left
				self.fireballInstance.direction = Vector2(1,0) # Right
			self.fireballInstance = null
			return

		if self.tileType == TileType.POINT_BLOCK:
			if self.fireballInstance == null:
				return
			#print_debug("POINT_BLOCK tile hit.")
			self.fireballInstance.direction = -self.fireballInstance.direction
			self.fireballInstance = null
			return
		if self.tileType == TileType.BOUNCE:
			if self.fireballInstance == null:
				return
			#print_debug("Bouncing projectile.")
			self.fireballInstance.direction = -self.fireballInstance.direction
			self.fireballInstance = null
			return
		if self.tileType == TileType.TRIGGERTOP or self.tileType == TileType.TRIGGERBOTTOM or self.tileType == TileType.TRIGGERLEFT or self.tileType == TileType.TRIGGERRIGHT:
			if self.fireballInstance == null:
				return
			#print_debug("Trigger tile hit.")
			GameManager.points += 20
			self.fireballInstance = null
			reset_type(self)
			return
		return

func _process(_delta: float) -> void:
	tile_action()
	return

func _on_area_2d_body_shape_entered(_body_rid: RID, body: Fireball, _body_shape_index: int, _local_shape_index: int) -> void:
	self.fireballInstance = body
	return


func _on_area_2d_body_shape_exited(_body_rid: RID, _body: Fireball, _body_shape_index: int, _local_shape_index: int) -> void:
	self.fireballInstance = null
	return

func set_texture(node) -> void:
	var textureRectInstance: TextureRect = node.get_node("TextureRect")
	if node.tileType == TileType.EMPTY:
		textureRectInstance.texture = null
	if node.tileType == TileType.DESTRUCTIVE:
		textureRectInstance.texture = binTexture
	if node.tileType == TileType.TOPLEFTCORNER:
		textureRectInstance.texture = topLeftCornerTexture
	if node.tileType == TileType.TOPRIGHTCORNER:
		textureRectInstance.texture = topRightCornerTexture
	if node.tileType == TileType.BOTTOMLEFTCORNER:
		textureRectInstance.texture = bottomLeftCornerTexture
	if node.tileType == TileType.BOTTOMRIGHTCORNER:
		textureRectInstance.texture = bottomRightCornerTexture
	if node.tileType == TileType.POINT_BLOCK:
		textureRectInstance.texture = pointBlockTexture
	if node.tileType == TileType.BOUNCE:
		textureRectInstance.texture = bounceTexture
	if node.tileType == TileType.TRIGGERTOP:
		textureRectInstance.texture = triggerTexture
	if node.tileType == TileType.TRIGGERBOTTOM:
		textureRectInstance.texture = triggerTexture
	if node.tileType == TileType.TRIGGERLEFT:
		textureRectInstance.texture = triggerTexture
	if node.tileType == TileType.TRIGGERRIGHT:
		textureRectInstance.texture = triggerTexture
	return

func reset_type(node: Tile) -> void:
	node.tileType = TileType.EMPTY
	set_texture(node)
	return

# Specific check for top trigger.
func top_trigger_check() -> bool:
	self.isTopTrigger = true
	var topRaycastInstance: RayCast2D = get_node("Area2D/TopRaycast") as RayCast2D
	if topRaycastInstance.is_colliding() == true:
		#print_debug("Top trigger raycast is colliding with something.")
		var collider: Node = topRaycastInstance.get_collider()
		if collider.get_parent() is Tile:
			#print_debug("Top trigger is colliding with a tile.")
			if collider.get_parent().tileType != TileType.EMPTY:
				#print_debug("Top trigger is colliding with a non-empty tile.")
				return false
			if collider.get_parent().tileType == TileType.EMPTY:
				#print_debug("Top trigger is colliding with an empty tile.")
				self.topTriggerInstance = collider.get_parent() as Tile
				return true
		#print_debug("Top trigger is colliding with something that is not a tile.")
		return false
	#print_debug("Top trigger is not colliding with anything.")
	return false

func bottom_trigger_check() -> bool:
	self.isBottomTrigger = true
	var bottomRaycastInstance: RayCast2D = get_node("Area2D/BottomRaycast") as RayCast2D
	if bottomRaycastInstance.is_colliding() == true:
		#print_debug("Bottom trigger raycast is colliding with something.")
		var collider: Node = bottomRaycastInstance.get_collider()
		if collider.get_parent() is Tile:
			#print_debug("Bottom trigger is colliding with a tile.")
			if collider.get_parent().tileType != TileType.EMPTY:
				#print_debug("Bottom trigger is colliding with a non-empty tile.")
				return false
			if collider.get_parent().tileType == TileType.EMPTY:
				#print_debug("Bottom trigger is colliding with an empty tile.")
				self.bottomTriggerInstance = collider.get_parent() as Tile
				return true
		#print_debug("Bottom trigger is colliding with something that is not a tile.")
		return false
	#print_debug("Bottom trigger is not colliding with anything.")
	return false

func left_trigger_check() -> bool:
	self.isLeftTrigger = true
	var leftRaycastInstance: RayCast2D = get_node("Area2D/LeftRaycast") as RayCast2D
	if leftRaycastInstance.is_colliding() == true:
		#print_debug("Left trigger raycast is colliding with something.")
		var collider: Node = leftRaycastInstance.get_collider()
		if collider.get_parent() is Tile:
			#print_debug("Left trigger is colliding with a tile.")
			if collider.get_parent().tileType != TileType.EMPTY:
				#print_debug("Left trigger is colliding with a non-empty tile.")
				return false
			if collider.get_parent().tileType == TileType.EMPTY:
				#print_debug("Left trigger is colliding with an empty tile.")
				self.leftTriggerInstance = collider.get_parent() as Tile
				return true
		#print_debug("Left trigger is colliding with something that is not a tile.")
		return false
	#print_debug("Left trigger is not colliding with anything.")
	return false

func right_trigger_check() -> bool:
	self.isRightTrigger = true
	var rightRaycastInstance: RayCast2D = get_node("Area2D/RightRaycast") as RayCast2D
	if rightRaycastInstance.is_colliding() == true:
		#print_debug("Right trigger raycast is colliding with something.")
		var collider: Node = rightRaycastInstance.get_collider()
		if collider.get_parent() is Tile:
			#print_debug("Right trigger is colliding with a tile.")
			if collider.get_parent().tileType != TileType.EMPTY:
				#print_debug("Right trigger is colliding with a non-empty tile.")
				return false
			if collider.get_parent().tileType == TileType.EMPTY:
				#print_debug("Right trigger is colliding with an empty tile.")
				self.rightTriggerInstance = collider.get_parent() as Tile
				return true
		#print_debug("Right trigger is colliding with something that is not a tile.")
		return false
	#print_debug("Right trigger is not colliding with anything.")
	return false

# Checks if a trigger has been selected in options.
func is_trigger_selected() -> bool:
	for value in GameManager.selectedTileTrigger.values():
		if value == true:
			return true
		else:
			pass
	return false

func generate_points() -> void:
	get_node("Area2D/TopRaycast").enabled = true
	get_node("Area2D/BottomRaycast").enabled = true
	get_node("Area2D/LeftRaycast").enabled = true
	get_node("Area2D/RightRaycast").enabled = true

	await get_tree().process_frame

	if top_trigger_check():
		topTriggerInstance.tileType = TileType.TRIGGERTOP
		topTriggerInstance.set_texture(topTriggerInstance)
	if bottom_trigger_check():
		bottomTriggerInstance.tileType = TileType.TRIGGERBOTTOM
		bottomTriggerInstance.set_texture(bottomTriggerInstance)
	if left_trigger_check():
		leftTriggerInstance.tileType = TileType.TRIGGERLEFT
		leftTriggerInstance.set_texture(leftTriggerInstance)
	if right_trigger_check():
		rightTriggerInstance.tileType = TileType.TRIGGERRIGHT
		rightTriggerInstance.set_texture(rightTriggerInstance)

#! Checks if selected trigger can be placed. Needs to be updated with addition of more trigger options.
func check_trigger(dictionary: Dictionary) -> bool:
	if GameManager.selectedTileType == TileType.POINT_BLOCK:
		if is_trigger_selected() == false:
			print_debug("No trigger options selected.")
			return false
		if dictionary["TOP"] == true:
			if top_trigger_check() == false:
				self.topTriggerInstance = null
				print_debug("Top trigger check failed.")
				return false
		if dictionary["BOTTOM"] == true:
			if bottom_trigger_check() == false:
				self.bottomTriggerInstance = null
				print_debug("Bottom trigger check failed.")
				return false
		if dictionary["LEFT"] == true:
			if left_trigger_check() == false:
				self.leftTriggerInstance = null
				print_debug("Left trigger check failed.")
				return false
		if dictionary["RIGHT"] == true:
			if right_trigger_check() == false:
				self.rightTriggerInstance = null
				print_debug("Right trigger check failed.")
				return false

	# Changes the tile type of the trigger tiles to the correct trigger tile type, and sets their texture.
	if self.topTriggerInstance != null:
		self.topTriggerInstance.tileType = TileType.TRIGGERTOP
		self.topTriggerInstance.set_texture(self.topTriggerInstance)
	if self.bottomTriggerInstance != null:
		self.bottomTriggerInstance.tileType = TileType.TRIGGERBOTTOM
		self.bottomTriggerInstance.set_texture(self.bottomTriggerInstance)
	if self.leftTriggerInstance != null:
		self.leftTriggerInstance.tileType = TileType.TRIGGERLEFT
		self.leftTriggerInstance.set_texture(self.leftTriggerInstance)
	if self.rightTriggerInstance != null:
		self.rightTriggerInstance.tileType = TileType.TRIGGERRIGHT
		self.rightTriggerInstance.set_texture(self.rightTriggerInstance)

	return true

# Chhecks if selected tile is empty.
func empty_check() -> bool:
	if self.tileType != TileType.EMPTY:
		print_debug("Tile is not empty.")
		return false
	return true

func _on_pressed() -> void:
	if GameManager.tile_dictionary.has(str(dictionary_position)) == false:
		print_debug("Error: Tile data not found for position ", dictionary_position)
		return

	if GameManager.tile_dictionary[str(dictionary_position)]["Type"] == "Hole":
		print_debug("Tile ", dictionary_position, " has a hole. You cannot place a tile on tile.")
		return

	# Makes it so that you cannot replace tiles with empty tiles.
	if GameManager.selectedTileType == TileType.EMPTY:
		if empty_check() == false:
			print_debug("You cannot replace a non-empty tile with an empty tile.")
			return
	# Makes it so you cannot replace non-empty tiles with other non-empty tiles without first replacing them with empty tiles.
	elif empty_check() == false:
		print_debug("You cannot replace a non-empty tile with another tile. You must first replace it with an empty tile.")
		return

	# Checks if trigger options are selected, and if so, checks if the trigger can be placed.
	if check_trigger(GameManager.selectedTileTrigger) == false:
		print_debug("Could not place tile.")
		return

	self.tileType = GameManager.selectedTileType
	set_texture(self)

	# Reset selected tile type and trigger options after placing tile.
	GameManager.selectedTileType = TileType.EMPTY
	return
