extends Label


func _process(delta: float) -> void:
	text = "Blood Coins: " + str(GameManager.player_controller.inventory_manager.blood_coins)
