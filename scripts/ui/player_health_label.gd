extends Label

func _process(delta: float) -> void:
	text = "Health: " + str(GameManager.player_controller.health_component.current_health)
