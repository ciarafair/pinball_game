extends RichTextLabel

func _process(_delta: float) -> void:
    self.text = "Points: " + str(GameManager.points)
