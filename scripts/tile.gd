class_name Tile extends Control

enum TileType {EMPTY, DESTRUCTIVE, PLUS90, MINUS90, PLUS180, MINUS180, TRIGGERTOP, TRIGGERBOTTOM, TRIGGERLEFT, TRIGGERRIGHT, COUNTER}
var binTexture: Resource = preload("res://assets/textures/bin.png")
var plus90Texture: Resource = preload("res://assets/textures/plus90.png")
var minus90Texture: Resource = preload("res://assets/textures/minus90.png")
var plus180Texture: Resource = preload("res://assets/textures/plus180.png")
var minus180Texture: Resource = preload("res://assets/textures/minus180.png")
var triggerTexture: Resource = preload("res://assets/textures/point.png")
var counterTexture: Resource = preload("res://assets/textures/counter.png")

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

func _ready() -> void:
    set_texture()
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
        if self.tileType == TileType.PLUS90:
            #print_debug("Rotating projectile 90 degrees.")
            self.fireballInstance.dir += 1.5708
            self.fireballInstance = null
            return
        if self.tileType == TileType.MINUS90:
            #print_debug("Rotating projectile -90 degrees.")
            self.fireballInstance.dir -= 1.5708 
            self.fireballInstance = null
            return
        if self.tileType == TileType.PLUS180:
            #print_debug("Rotating projectile 180 degrees.")
            self.fireballInstance.dir += 3.14159
            self.fireballInstance = null
            return
        if self.tileType == TileType.MINUS180:
            #print_debug("Rotating projectile 180 degrees.")
            self.fireballInstance.dir -= 3.14159
            self.fireballInstance = null
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

func set_texture() -> void:
    var textureRectInstance: TextureRect = get_node("TextureRect")
    if self.tileType == TileType.EMPTY:
        textureRectInstance.texture = null
    if self.tileType == TileType.DESTRUCTIVE:
        textureRectInstance.texture = binTexture
    if self.tileType == TileType.PLUS90:
        textureRectInstance.texture = plus90Texture
    if self.tileType == TileType.MINUS90:
        textureRectInstance.texture = minus90Texture
    if self.tileType == TileType.PLUS180:
        textureRectInstance.texture = plus180Texture
    if self.tileType == TileType.MINUS180:
        textureRectInstance.texture = minus180Texture
    if self.tileType == TileType.COUNTER:
        textureRectInstance.texture = counterTexture
    if self.tileType == TileType.TRIGGERTOP:
        textureRectInstance.texture = triggerTexture
    if self.tileType == TileType.TRIGGERBOTTOM:
        textureRectInstance.texture = triggerTexture
        textureRectInstance.flip_v = true
    if self.tileType == TileType.TRIGGERLEFT:
        textureRectInstance.texture = triggerTexture
        textureRectInstance.rotation_degrees = -90
    if self.tileType == TileType.TRIGGERRIGHT:
        textureRectInstance.texture = triggerTexture
        textureRectInstance.rotation_degrees = 90
    return

# Specific check for top trigger.
func top_trigger_check() -> bool:
    self.isTopTrigger = true
    var topRaycastInstance: RayCast2D = get_node("Area2D/TopRaycast") as RayCast2D
    if topRaycastInstance.is_colliding() == true:
        print_debug("Top trigger raycast is colliding with something.")
        var collider: Node = topRaycastInstance.get_collider()
        if collider.get_parent() is Tile:
            print_debug("Top trigger is colliding with a tile.")
            if collider.get_parent().tileType != TileType.EMPTY:
                print_debug("Top trigger is colliding with a non-empty tile.")
                return false
            if collider.get_parent().tileType == TileType.EMPTY:
                print_debug("Top trigger is colliding with an empty tile.")
                self.topTriggerInstance = collider.get_parent() as Tile
                return true
        print_debug("Top trigger is colliding with something that is not a tile.")
        return false
    print_debug("Top trigger is not colliding with anything.")
    return false

func bottom_trigger_check() -> bool:
    self.isBottomTrigger = true
    var bottomRaycastInstance: RayCast2D = get_node("Area2D/BottomRaycast") as RayCast2D
    if bottomRaycastInstance.is_colliding() == true:
        print_debug("Bottom trigger raycast is colliding with something.")
        var collider: Node = bottomRaycastInstance.get_collider()
        if collider.get_parent() is Tile:
            print_debug("Bottom trigger is colliding with a tile.")
            if collider.get_parent().tileType != TileType.EMPTY:
                print_debug("Bottom trigger is colliding with a non-empty tile.")
                return false
            if collider.get_parent().tileType == TileType.EMPTY:
                print_debug("Bottom trigger is colliding with an empty tile.")
                self.bottomTriggerInstance = collider.get_parent() as Tile
                return true
        print_debug("Bottom trigger is colliding with something that is not a tile.")
        return false
    print_debug("Bottom trigger is not colliding with anything.")
    return false   

func left_trigger_check() -> bool:
    self.isLeftTrigger = true
    var leftRaycastInstance: RayCast2D = get_node("Area2D/LeftRaycast") as RayCast2D
    if leftRaycastInstance.is_colliding() == true:
        print_debug("Left trigger raycast is colliding with something.")
        var collider: Node = leftRaycastInstance.get_collider()
        if collider.get_parent() is Tile:
            print_debug("Left trigger is colliding with a tile.")
            if collider.get_parent().tileType != TileType.EMPTY:
                print_debug("Left trigger is colliding with a non-empty tile.")
                return false
            if collider.get_parent().tileType == TileType.EMPTY:
                print_debug("Left trigger is colliding with an empty tile.")
                self.leftTriggerInstance = collider.get_parent() as Tile
                return true
        print_debug("Left trigger is colliding with something that is not a tile.")
        return false
    print_debug("Left trigger is not colliding with anything.")
    return false

func right_trigger_check() -> bool:
    self.isRightTrigger = true
    var rightRaycastInstance: RayCast2D = get_node("Area2D/RightRaycast") as RayCast2D
    if rightRaycastInstance.is_colliding() == true:
        print_debug("Right trigger raycast is colliding with something.")
        var collider: Node = rightRaycastInstance.get_collider()
        if collider.get_parent() is Tile:
            print_debug("Right trigger is colliding with a tile.")
            if collider.get_parent().tileType != TileType.EMPTY:
                print_debug("Right trigger is colliding with a non-empty tile.")
                return false
            if collider.get_parent().tileType == TileType.EMPTY:
                print_debug("Right trigger is colliding with an empty tile.")
                self.rightTriggerInstance = collider.get_parent() as Tile
                return true
        print_debug("Right trigger is colliding with something that is not a tile.")
        return false
    print_debug("Right trigger is not colliding with anything.")
    return false

# Checks if a trigger has been selected in options.
func is_trigger_selected() -> bool:
    for value in GameManager.selectedTileTrigger.values():
        if value == true:
            return true
        else:
            pass
    return false

#! Checks if selected trigger can be placed. Needs to be updated with addition of more trigger options.
func check_trigger() -> bool:
    if GameManager.selectedTileType == TileType.COUNTER:
        if is_trigger_selected() == false:
            print_debug("No trigger options selected.")
            return false
        if GameManager.selectedTileTrigger["TOP"] == true:
            if top_trigger_check() == false:
                self.topTriggerInstance = null
                print_debug("Top trigger check failed.")
                return false
        if GameManager.selectedTileTrigger["BOTTOM"] == true:
            if bottom_trigger_check() == false:
                self.bottomTriggerInstance = null
                print_debug("Bottom trigger check failed.")
                return false
        if GameManager.selectedTileTrigger["LEFT"] == true:
            if left_trigger_check() == false:
                self.leftTriggerInstance = null
                print_debug("Left trigger check failed.")
                return false
        if GameManager.selectedTileTrigger["RIGHT"] == true:
            if right_trigger_check() == false:
                self.rightTriggerInstance = null
                print_debug("Right trigger check failed.")
                return false

    # Changes the tile type of the trigger tiles to the correct trigger tile type, and sets their texture.
    if self.topTriggerInstance != null:
        self.topTriggerInstance.tileType = TileType.TRIGGERTOP
        self.topTriggerInstance.set_texture()
    if self.bottomTriggerInstance != null:
        self.bottomTriggerInstance.tileType = TileType.TRIGGERBOTTOM
        self.bottomTriggerInstance.set_texture()
    if self.leftTriggerInstance != null:
        self.leftTriggerInstance.tileType = TileType.TRIGGERLEFT
        self.leftTriggerInstance.set_texture()
    if self.rightTriggerInstance != null:
        self.rightTriggerInstance.tileType = TileType.TRIGGERRIGHT
        self.rightTriggerInstance.set_texture() 

    return true

# Chhecks if selected tile is empty.
func empty_check() -> bool:
    if self.tileType != TileType.EMPTY:
        print_debug("Tile is not empty.")
        return false
    return true

func _on_pressed() -> void:

    # Makes it so that you can only replace tiles with empty tiles, and you can only place non-empty tiles on empty tiles.
    if GameManager.selectedTileType != TileType.EMPTY:
        if empty_check() == false:
            print_debug("Could not place tile as there is a tile already there.")
            return

    # Checks if trigger options are selected, and if so, checks if the trigger can be placed.
    if check_trigger() == false:
        print_debug("Could not place tile.")
        return

    self.tileType = GameManager.selectedTileType
    set_texture()
    return
