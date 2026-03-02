extends VBoxContainer


func _process(_delta: float) -> void:
	if GameManager.selectedTileType != Tile.TileType.POINT_BLOCK:
		self.visible = false
	else: 
		self.visible = true

func _on_right_trigger_check_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		GameManager.selectedTileTrigger["RIGHT"] = true
		print_debug('GameManager.selectedTileTrigger["RIGHT"] = ', GameManager.selectedTileTrigger["RIGHT"])
	if toggled_on == false:
		GameManager.selectedTileTrigger["RIGHT"] = false
		print_debug('GameManager.selectedTileTrigger["RIGHT"] = ', GameManager.selectedTileTrigger["RIGHT"])
	return

func _on_left_trigger_check_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		GameManager.selectedTileTrigger["LEFT"] = true
		print_debug('GameManager.selectedTileTrigger["LEFT"] = ', GameManager.selectedTileTrigger["LEFT"])
	if toggled_on == false:
		GameManager.selectedTileTrigger["LEFT"] = false
		print_debug('GameManager.selectedTileTrigger["LEFT"] = ', GameManager.selectedTileTrigger["LEFT"])
	return

func _on_bottom_trigger_check_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		GameManager.selectedTileTrigger["BOTTOM"] = true
		print_debug('GameManager.selectedTileTrigger["BOTTOM"] = ', GameManager.selectedTileTrigger["BOTTOM"])
	if toggled_on == false:
		GameManager.selectedTileTrigger["BOTTOM"] = false
		print_debug('GameManager.selectedTileTrigger["BOTTOM"] = ', GameManager.selectedTileTrigger["BOTTOM"])
	return

func _on_top_trigger_check_toggled(toggled_on: bool) -> void:
	if toggled_on == true:
		GameManager.selectedTileTrigger["TOP"] = true
		print_debug('GameManager.selectedTileTrigger["TOP"] = ', GameManager.selectedTileTrigger["TOP"])
	if toggled_on == false:
		GameManager.selectedTileTrigger["TOP"] = false
		print_debug('GameManager.selectedTileTrigger["TOP"] = ', GameManager.selectedTileTrigger["TOP"])
	return
