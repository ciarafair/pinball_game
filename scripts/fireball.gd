class_name Fireball extends CharacterBody2D

@export var speed: int = 200
var direction: Vector2 = Vector2(0, 0)

func _physics_process(_delta: float) -> void:
	velocity = direction * speed
	move_and_slide()

func _on_area_2d_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body is CharacterBody2D and body != self:
			self.queue_free()
			body.queue_free()
