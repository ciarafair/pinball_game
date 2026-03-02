class_name Fireball extends CharacterBody2D

var pos: Vector2
var rota: float
var dir: float 
@export var speed: int = 200

func _ready() -> void:
    global_position = pos
    global_rotation = rota 

func _physics_process(_delta: float) -> void:

    var snapped_dir = round(dir / (PI / 2)) * (PI / 2)
    velocity = Vector2.RIGHT.rotated(snapped_dir) * speed
    
    move_and_slide()

func _on_area_2d_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
    if body is CharacterBody2D and body != self:
            self.queue_free()
            body.queue_free()